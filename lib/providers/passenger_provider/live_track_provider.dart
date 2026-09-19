import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sajilo_bus/config/dio_client.dart';
import '../../services/location_service.dart';

/// =========================================================
/// MODELS
/// =========================================================

enum MilestoneState { passed, current, scheduled, destination }

class RouteMilestone {
  final String title;
  final String subtitle;
  final String trailing;
  final MilestoneState state;

  const RouteMilestone({
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.state,
  });
}

/// =========================================================
/// PROVIDER
/// =========================================================
class LiveTrackProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _busNumber = "BA 2 KHA 8492";
  String _driverName = "Ram Bahadur Shrestha";
  String _routeFrom = "Biratnagar";
  String _routeTo = "Itahari";
  String _speedText = "38 km/h";
  int _occupiedSeats = 32;
  int _totalSeats = 40;

  // Real-time location coordinates
  LatLng _busLocation = const LatLng(26.4837, 87.2834);
  LatLng _passengerLocation = const LatLng(26.4525, 87.2718);
  double _distanceKm = 1.4;
  int _etaMinutes = 3;

  Timer? _pollingTimer;
  StreamSubscription<Position>? _positionSubscription;
  final LocationService _locationService = LocationService();

  String _statusLabel = "ACTIVE";
  String _nextStopName = "Terminal";
  String _nextStopStatus = "Approaching";
  List<RouteMilestone> _milestones = [];
  String _stopsRemainingText = "0 Stops Remaining";

  LatLng get busLocation => _busLocation;
  LatLng get passengerLocation => _passengerLocation;
  double get distanceKm => _distanceKm;

  LiveTrackProvider() {
    initLiveTracking();
  }

  Future<void> initLiveTracking() async {
    fetchActiveTrip();
    _startPassengerLocationSubscription();

    // Poll active trip bus location every 5 seconds
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      fetchActiveTrip();
    });
  }

  void _startPassengerLocationSubscription() async {
    final stream = _locationService.getPositionStream();
    if (stream != null) {
      _positionSubscription = stream.listen((position) {
        _passengerLocation = LatLng(position.latitude, position.longitude);
        _updateDistanceAndEta();
        notifyListeners();
      });
    } else {
      // Fallback one-time fetch
      final pos = await _locationService.getCurrentLocation();
      if (pos != null) {
        _passengerLocation = LatLng(pos.latitude, pos.longitude);
        _updateDistanceAndEta();
        notifyListeners();
      }
    }
  }

  Future<void> fetchActiveTrip() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");
      if (token != null) {
        final response = await DioClient.dio.get(
          "/trips/active",
          options: Options(headers: {"Authorization": "Bearer $token"}),
        );
        if (response.statusCode == 200 && response.data["success"] == true) {
          final trip = response.data["activeTrip"] ?? (response.data["trips"] as List?)?.firstOrNull;
          if (trip != null) {
            _busNumber = trip["bus"]?["busNumber"] ?? _busNumber;
            _driverName = trip["driver"]?["name"] ?? _driverName;
            _routeFrom = trip["route"]?["startPoint"] ?? _routeFrom;
            _routeTo = trip["route"]?["endPoint"] ?? _routeTo;
            _totalSeats = trip["bus"]?["capacity"] ?? 40;

            // Status updates dynamically based on endedAt / status
            if (trip["endedAt"] != null) {
              _statusLabel = "COMPLETED";
            } else {
              _statusLabel = "ACTIVE";
            }

            final latestPing = (trip["tripHistory"] as List?)?.firstOrNull;
            if (latestPing != null) {
              final double? lat = double.tryParse(latestPing["latitude"].toString());
              final double? lng = double.tryParse(latestPing["longitude"].toString());
              if (lat != null && lng != null) {
                _busLocation = LatLng(lat, lng);
                _updateDistanceAndEta();
              }
            }

            // Stop Events & Route details calculation
            final routeDetails = (trip["route"]?["routeDetails"] as List?) ?? [];
            final stopEvents = (trip["stopEvents"] as List?) ?? [];

            // Calculate occupancy count from boarding/alighting
            int occupancy = 0;
            for (var event in stopEvents) {
              final b = (event["boardingCount"] as num?)?.toInt() ?? 0;
              final a = (event["alightingCount"] as num?)?.toInt() ?? 0;
              occupancy += (b - a);
            }
            if (occupancy < 0) occupancy = 0;
            _occupiedSeats = occupancy;

            // Build dynamic milestones and next stop
            final Set<int> reachedStopIds = {};
            final Set<int> skippedStopIds = {};
            for (var event in stopEvents) {
              final int? stopId = event["busStopId"] as int?;
              final String? eventType = event["eventType"] as String?;
              if (stopId != null) {
                if (eventType == "REACHED") reachedStopIds.add(stopId);
                if (eventType == "SKIPPED") skippedStopIds.add(stopId);
              }
            }

            List<RouteMilestone> newMilestones = [];
            int upcomingCount = 0;
            String? currentOrNextStop;

            for (int i = 0; i < routeDetails.length; i++) {
              final rd = routeDetails[i];
              final busStop = rd["busStop"];
              final stopId = busStop?["id"] as int?;
              final stopName = busStop?["stopName"] ?? "Stop #${i + 1}";

              MilestoneState state = MilestoneState.scheduled;
              String subtitle = "Scheduled";
              String trailing = "";

              if (stopId != null && reachedStopIds.contains(stopId)) {
                state = MilestoneState.passed;
                subtitle = "Passed";
              } else if (stopId != null && skippedStopIds.contains(stopId)) {
                state = MilestoneState.passed;
                subtitle = "Skipped";
              } else if (currentOrNextStop == null) {
                state = MilestoneState.current;
                subtitle = "Pickup / Current Stop";
                trailing = "NOW";
                currentOrNextStop = stopName;
                upcomingCount++;
              } else if (i == routeDetails.length - 1) {
                state = MilestoneState.destination;
                subtitle = "Destination";
                upcomingCount++;
              } else {
                state = MilestoneState.scheduled;
                subtitle = "Scheduled";
                upcomingCount++;
              }

              newMilestones.add(RouteMilestone(
                title: stopName,
                subtitle: subtitle,
                trailing: trailing,
                state: state,
              ));
            }

            if (newMilestones.isNotEmpty) {
              _milestones = newMilestones;
              _stopsRemainingText = "$upcomingCount Stops Remaining";
              if (currentOrNextStop != null) {
                _nextStopName = currentOrNextStop;
                _nextStopStatus = "Approaching";
              } else {
                _nextStopName = _routeTo;
                _nextStopStatus = "Arrived / Final";
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint("Live track fetch error: $e");
    } finally {
      notifyListeners();
    }
  }

  void _updateDistanceAndEta() {
    final Distance distance = const Distance();
    final double meter = distance(_passengerLocation, _busLocation);
    _distanceKm = (meter / 1000.0);
    // Assume avg speed of 30 km/h (0.5 km/min)
    _etaMinutes = (_distanceKm * 2).round();
    if (_etaMinutes < 1) _etaMinutes = 1;
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _positionSubscription?.cancel();
    super.dispose();
  }

  // ---------- App bar ----------
  String get screenTitle => "Sajilo Bus";
  String get avatarUrl => "https://i.pravatar.cc/100?img=47";

  // ---------- Map overlays ----------
  String get routeNumber => "Route Live";
  String get routeFrom => _routeFrom;
  String get routeTo => _routeTo;
  String get gpsStatus => "GPS 100% • Live";

  String get busPlateChip => _busNumber;
  String get youAreHereLabel => "You are here";
  String get nextStopChip => "Next Stop";

  // ---------- Vehicle header ----------
  String get busNumber => _busNumber;
  String get serviceType => "Fast Express";
  String get statusLabel => _statusLabel;
  String get plateNumber => _busNumber;
  String get driverName => _driverName;

  String get vehicleSubtitle => "Plate: $plateNumber • Driver: $driverName";

  // ---------- Metric cards ----------
  String get arrivalValue => "$_etaMinutes mins";
  String get arrivalSubtitle => "Live ETA to pickup";

  String get distanceValue => "${_distanceKm.toStringAsFixed(1)} km";
  String get speedSubtitle => "Speed: $_speedText";

  int get occupiedSeats => _occupiedSeats;
  int get totalSeats => _totalSeats;
  double get crowdRatio => totalSeats > 0 ? (occupiedSeats / totalSeats).clamp(0.0, 1.0) : 0.0;

  String get nextStopName => _nextStopName;
  String get nextStopStatus => _nextStopStatus;

  // ---------- Route milestones ----------
  String get milestonesTitle => "ROUTE MILESTONES";
  String get stopsRemaining => _stopsRemainingText;

  List<RouteMilestone> get milestones => _milestones.isNotEmpty ? _milestones : const [
    RouteMilestone(
      title: "Origin Terminal",
      subtitle: "Passed",
      trailing: "",
      state: MilestoneState.passed,
    ),
    RouteMilestone(
      title: "Current Stop",
      subtitle: "In Transit",
      trailing: "NOW",
      state: MilestoneState.current,
    ),
  ];

  // ---------- Actions ----------
  void goBack(BuildContext context) => Navigator.maybePop(context);

  void openProfile() {}

  void recenterMap() {}

  void toggleMapLayer() {}

  void setAlert() {}

  void shareTrip() {}

  void triggerSos() {}
}