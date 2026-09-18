import 'package:flutter/material.dart';

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
  // ---------- App bar ----------
  String get screenTitle => "Sajilo Bus";
  String get avatarUrl => "https://i.pravatar.cc/100?img=47";

  // ---------- Map overlays ----------
  String get routeNumber => "Route 104";
  String get routeFrom => "Biratnagar";
  String get routeTo => "Itahari";
  String get gpsStatus => "GPS 100% • 5s ago";

  String get busPlateChip => "BA 2 KHA 8492";
  String get youAreHereLabel => "You are here";
  String get nextStopChip => "Tankisinuwari (2m)";

  // ---------- Vehicle header ----------
  String get busNumber => "BA 2 KHA 8492";
  String get serviceType => "Fast Express";
  String get statusLabel => "ACTIVE";
  String get plateNumber => "Ko 2 Pa 9841";
  String get driverName => "Ram Bahadur Shrestha";

  String get vehicleSubtitle => "Plate: $plateNumber • Driver: $driverName";

  // ---------- Metric cards ----------
  String get arrivalValue => "3 mins";
  String get arrivalSubtitle => "Live ETA to pickup";

  String get distanceValue => "1.4 km";
  String get speedSubtitle => "Speed: 38 km/h";

  int get occupiedSeats => 32;
  int get totalSeats => 40;
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