import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sajilo_bus/config/dio_client.dart';

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

  LiveTrackProvider() {
    fetchActiveTrip();
  }

  Future<void> fetchActiveTrip() async {
    _isLoading = true;
    notifyListeners();

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
          }
        }
      }
    } catch (e) {
      debugPrint("Live track fetch error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ---------- App bar ----------
  String get screenTitle => "Sajilo Bus";
  String get avatarUrl => "https://i.pravatar.cc/100?img=47";

  // ---------- Map overlays ----------
  String get routeNumber => "Route Live";
  String get routeFrom => _routeFrom;
  String get routeTo => _routeTo;
  String get gpsStatus => "GPS 100% • 5s ago";

  String get busPlateChip => _busNumber;
  String get youAreHereLabel => "You are here";
  String get nextStopChip => "Next Stop";

  // ---------- Vehicle header ----------
  String get busNumber => _busNumber;
  String get serviceType => "Fast Express";
  String get statusLabel => "ACTIVE";
  String get plateNumber => _busNumber;
  String get driverName => _driverName;

  String get vehicleSubtitle => "Plate: $plateNumber • Driver: $driverName";

  // ---------- Metric cards ----------
  String get arrivalValue => "3 mins";
  String get arrivalSubtitle => "Live ETA to pickup";

  String get distanceValue => "1.4 km";
  String get speedSubtitle => "Speed: $_speedText";

  int get occupiedSeats => _occupiedSeats;
  int get totalSeats => _totalSeats;
  double get crowdRatio => occupiedSeats / totalSeats;

  String get nextStopName => "Tankisinuwari";
  String get nextStopStatus => "Approaching";

  // ---------- Route milestones ----------
  String get milestonesTitle => "ROUTE MILESTONES";
  String get stopsRemaining => "4 Stops Remaining";

  final List<RouteMilestone> milestones = const [
    RouteMilestone(
      title: "Bargachhi Hub",
      subtitle: "Passed • 09:37 AM",
      trailing: "",
      state: MilestoneState.passed,
    ),
    RouteMilestone(
      title: "Tankisinuwari",
      subtitle: "In ~2 mins • Pickup stop",
      trailing: "NOW",
      state: MilestoneState.current,
    ),
    RouteMilestone(
      title: "Duhabi Chowk",
      subtitle: "Scheduled • 09:54 AM",
      trailing: "11m",
      state: MilestoneState.scheduled,
    ),
    RouteMilestone(
      title: "Itahari Central Bus Terminal",
      subtitle: "Destination • 10:15 AM",
      trailing: "32m",
      state: MilestoneState.destination,
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