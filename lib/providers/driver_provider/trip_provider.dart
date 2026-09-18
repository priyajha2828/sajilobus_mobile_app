import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sajilo_bus/config/dio_client.dart';
import '../../services/driver_service.dart';
import '../../services/location_service.dart';

/// Status of a single stop in the route timeline.
enum StopStatus { completed, current, upcoming, finalStop }

class RouteStop {
  final int index;
  final String name;
  final String subtitle;
  final String timeLabel;
  StopStatus status;
  final double distanceKm; // distance from previous / origin, for display
  final String? etaLabel; // e.g. "Est. 6 mins"
  final String? extraInfo; // e.g. "+14 boarding", "4 entering"
  final String? extraInfoSecondary; // e.g. "2 exiting"

  RouteStop({
    required this.index,
    required this.name,
    required this.subtitle,
    required this.timeLabel,
    required this.status,
    this.distanceKm = 0,
    this.etaLabel,
    this.extraInfo,
    this.extraInfoSecondary,
  });
}

class TripProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int? activeTripId;

  // Header / status
  bool driverOnline = true;
  bool liveGpsOn = true;

  // Real-time location
  LatLng driverLocation = const LatLng(26.4837, 87.2834);
  StreamSubscription<Position>? _locationSubscription;
  final LocationService _locationService = LocationService();
  DateTime? _lastPingTime;

  // Route summary
  String originCity = 'Biratnagar';
  String destinationCity = 'Itahari';
  String roadName = 'Koshi Highway Express';
  String routeCode = 'BA 2 KHA 4567';

  // Speed
  int currentSpeed = 42;
  int speedLimit = 50;

  // Passengers
  int passengersOnboard = 32;
  int passengerCapacity = 40;
  int get vacantSeats => passengerCapacity - passengersOnboard;

  // Distance / ETA
  double distanceRemainingKm = 14.2;
  double distanceCoveredKm = 6.8;
  int etaMinutes = 25;
  String etaArrivalTime = '10:45 AM';
  bool isOnTime = true;

  // Duration / stops banner
  String durationElapsedLabel = '1h 10m elapsed';
  int stopsRemaining = 3;

  // Map
  String currentRoadSegment = 'NH-08 Koshi Northbound';
  String nextDirectionText = 'In 450m keep straight for Tan...';
  String nextDirectionDistance = '450m';
  bool trafficSignalActive = true;

  // Stop timeline
  int currentStopIndex = 3;
  int get totalStops => stops.length;

  List<RouteStop> stops = [
    RouteStop(
      index: 1,
      name: 'Biratnagar Bus Park',
      subtitle: 'Origin Point • Departed on schedule',
      timeLabel: '08:30 AM',
      status: StopStatus.completed,
    ),
    RouteStop(
      index: 2,
      name: 'Traffic Chowk',
      subtitle: 'Urban Station • +14 boarding',
      timeLabel: '08:52 AM',
      status: StopStatus.completed,
    ),
    RouteStop(
      index: 3,
      name: 'Mahendra Chowk',
      subtitle: 'Arrived just now • Exchange stop',
      timeLabel: '',
      status: StopStatus.current,
      extraInfo: '4 entering',
      extraInfoSecondary: '2 exiting',
    ),
    RouteStop(
      index: 4,
      name: 'Tankisinuwari',
      subtitle: 'Industrial corridor',
      timeLabel: 'Next • 2.5 km',
      status: StopStatus.upcoming,
      etaLabel: 'Est. 6 mins',
    ),
    RouteStop(
      index: 5,
      name: 'Duhabi',
      subtitle: 'Bridge crossing',
      timeLabel: 'Upcoming • 8.0 km',
      status: StopStatus.upcoming,
      etaLabel: 'Est. 15 mins',
    ),
    RouteStop(
      index: 6,
      name: 'Itahari Bus Park',
      subtitle: 'Terminus • Platform 4',
      timeLabel: 'Final • 14.2 km',
      status: StopStatus.finalStop,
    ),
  ];

  final DriverService _driverService = DriverService();

  TripProvider() {
    fetchActiveTrip();
    _startLocationBroadcasting();
  }

  void _startLocationBroadcasting() {
    final stream = _locationService.getPositionStream();
    if (stream != null) {
      _locationSubscription = stream.listen((position) {
        driverLocation = LatLng(position.latitude, position.longitude);
        currentSpeed = (position.speed * 3.6).round(); // m/s to km/h
        if (currentSpeed < 0) currentSpeed = 0;
        notifyListeners();

        // Broadcast to backend at most once every 5 seconds if active trip exists
        final now = DateTime.now();
        if (activeTripId != null && (_lastPingTime == null || now.difference(_lastPingTime!).inSeconds >= 5)) {
          _lastPingTime = now;
          _broadcastLocationToBackend(position.latitude, position.longitude, currentSpeed.toDouble());
        }
      });
    }
  }

  Future<void> _broadcastLocationToBackend(double lat, double lng, double speed) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");
      if (token != null && activeTripId != null) {
        await _driverService.recordLocation(token, activeTripId!, lat, lng, speed: speed);
      }
    } catch (e) {
      debugPrint("Error broadcasting driver location: $e");
    }
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> fetchActiveTrip() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");

      if (token != null && token.isNotEmpty) {
        final response = await DioClient.dio.get(
          "/trips/active",
          options: Options(headers: {"Authorization": "Bearer $token"}),
        );

        if (response.statusCode == 200 && response.data["success"] == true) {
          final trip = response.data["activeTrip"] ?? (response.data["trips"] as List?)?.firstOrNull;
          if (trip != null) {
            activeTripId = trip["id"];
            if (trip["route"] != null) {
              originCity = trip["route"]["startPoint"] ?? originCity;
              destinationCity = trip["route"]["endPoint"] ?? destinationCity;
              roadName = trip["route"]["routeName"] ?? roadName;
            }
            if (trip["bus"] != null) {
              routeCode = trip["bus"]["plateNumber"] ?? trip["bus"]["busNumber"] ?? routeCode;
              passengerCapacity = trip["bus"]["capacity"] ?? 40;
            }

            // Parse stops from routeDetails if available
            final routeDetails = trip["route"]?["routeDetails"] as List?;
            if (routeDetails != null && routeDetails.isNotEmpty) {
              List<RouteStop> parsedStops = [];
              for (int i = 0; i < routeDetails.length; i++) {
                final rd = routeDetails[i];
                final busStop = rd["busStop"];
                final stopName = busStop?["stopName"] ?? "Stop #${i + 1}";
                
                StopStatus status = StopStatus.upcoming;
                if (i == 0) status = StopStatus.completed;
                else if (i == 1) status = StopStatus.current;
                else if (i == routeDetails.length - 1) status = StopStatus.finalStop;

                parsedStops.add(RouteStop(
                  index: i + 1,
                  name: stopName,
                  subtitle: rd["remarks"] ?? "Route Station",
                  timeLabel: i == 0 ? "Departed" : (i == routeDetails.length - 1 ? "Final" : "Next"),
                  status: status,
                ));
              }
              stops = parsedStops;
            }
          }
        }
      }
    } catch (e) {
      debugPrint("TripProvider active trip fetch error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markReachedStop() async {
    final currentIdx = stops.indexWhere((s) => s.status == StopStatus.current);
    if (currentIdx == -1) return;

    final currentStop = stops[currentIdx];
    stops[currentIdx].status = StopStatus.completed;

    final nextIdx = currentIdx + 1;
    if (nextIdx < stops.length) {
      if (stops[nextIdx].status == StopStatus.upcoming) {
        stops[nextIdx].status = StopStatus.current;
        currentStopIndex = stops[nextIdx].index;
      }
      if (stopsRemaining > 0) stopsRemaining--;
    }
    notifyListeners();

    if (activeTripId != null) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("jwt_token");
        if (token != null) {
          await DioClient.dio.post(
            "/trips/$activeTripId/stop-events",
            data: {
              "busStopId": currentStop.index,
              "eventType": "REACHED",
              "boardingCount": 4,
              "alightingCount": 2,
            },
            options: Options(headers: {"Authorization": "Bearer $token"}),
          );
        }
      } catch (e) {
        debugPrint("Error recording reached stop event: $e");
      }
    }
  }

  Future<void> skipStop() async {
    final currentIdx = stops.indexWhere((s) => s.status == StopStatus.current);
    if (currentIdx == -1) return;

    final currentStop = stops[currentIdx];
    stops[currentIdx].status = StopStatus.completed;
    final nextIdx = currentIdx + 1;
    if (nextIdx < stops.length && stops[nextIdx].status == StopStatus.upcoming) {
      stops[nextIdx].status = StopStatus.current;
      currentStopIndex = stops[nextIdx].index;
    }
    if (stopsRemaining > 0) stopsRemaining--;
    notifyListeners();

    if (activeTripId != null) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("jwt_token");
        if (token != null) {
          await DioClient.dio.post(
            "/trips/$activeTripId/stop-events",
            data: {
              "busStopId": currentStop.index,
              "eventType": "SKIPPED",
            },
            options: Options(headers: {"Authorization": "Bearer $token"}),
          );
        }
      } catch (e) {
        debugPrint("Error recording skipped stop event: $e");
      }
    }
  }

  Future<void> triggerEmergency() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");
      if (token != null) {
        await _driverService.triggerSOS(token, {
          "tripId": activeTripId,
          "latitude": 26.4837,
          "longitude": 87.2834,
          "message": "Emergency triggered on trip from $originCity to $destinationCity",
        });
      }
    } catch (e) {
      debugPrint("TripProvider emergency error: $e");
    }
  }

  void updateSpeed(int speed) {
    currentSpeed = speed;
    notifyListeners();
  }
}