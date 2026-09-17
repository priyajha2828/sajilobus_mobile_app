import 'dart:async';
import 'package:flutter/material.dart';

/// Status of a single stop along the route timeline.
enum MilestoneStatus { passed, current, scheduled, destination }

class RouteMilestone {
  final String title;
  final String subtitle;
  final String? etaMinutesLabel; // e.g. "11m", "32m" — null for passed/current
  final MilestoneStatus status;

  const RouteMilestone({
    required this.title,
    required this.subtitle,
    required this.status,
    this.etaMinutesLabel,
  });
}

/// Holds all state shown on the Live Vehicle Tracker (passenger_sos) screen.
///
/// Wrap this above the screen with:
/// ```dart
/// ChangeNotifierProvider(create: (_) => VehicleTrackerProvider()..startListening())
/// ```
class VehicleTrackerProvider extends ChangeNotifier {
  // ---- Route header ----
  String routeNumber = '104';
  String routeFrom = 'Biratnagar';
  String routeTo = 'Itahari';

  // ---- GPS status ----
  double gpsSignalPercent = 100;
  int gpsLastUpdatedSeconds = 5;

  // ---- Vehicle info ----
  String vehiclePlate = 'BA 2 KHA 8492';
  String fullPlateNumber = 'Ko 2 Pa 9841';
  String driverName = 'Ram B....';
  String serviceTag = 'Fast Express';
  bool isActive = true;

  // ---- Live stats ----
  int arrivalEtaMinutes = 3;
  double distanceKm = 1.4;
  double speedKmh = 38;

  int crowdCurrent = 32;
  int crowdCapacity = 40;

  String nextStopName = 'Tankisinuwari';
  String nextStopStatus = 'Approaching';

  // ---- Route timeline ----
  int stopsRemaining = 4;
  List<RouteMilestone> milestones = const [
    RouteMilestone(
      title: 'Bargachhi Hub',
      subtitle: 'Passed • 09:37 AM',
      status: MilestoneStatus.passed,
    ),
    RouteMilestone(
      title: 'Tankisinuwari',
      subtitle: 'In ~2 mins • Pickup stop',
      status: MilestoneStatus.current,
    ),
    RouteMilestone(
      title: 'Duhabi Chowk',
      subtitle: 'Scheduled • 09:54 AM',
      status: MilestoneStatus.scheduled,
      etaMinutesLabel: '11m',
    ),
    RouteMilestone(
      title: 'Itahari Central Bus Terminal',
      subtitle: 'Destination • 10:15 AM',
      status: MilestoneStatus.destination,
      etaMinutesLabel: '32m',
    ),
  ];

  Timer? _pollTimer;

  double get crowdRatio =>
      crowdCapacity == 0 ? 0 : (crowdCurrent / crowdCapacity).clamp(0, 1);

  /// Starts simulated live polling (swap the body for a real socket/API call).
  void startListening() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (_) => _tick());
  }

  void _tick() {
    gpsLastUpdatedSeconds = 0;
    notifyListeners();
  }

  /// Called from the "locate me" map control.
  void recenterMap() {
    // Hook up to your map controller here.
    notifyListeners();
  }

  /// Called from the Alert bottom button.
  Future<void> sendAlert() async {
    // TODO: wire to your alert/notification API.
  }

  /// Called from the Share bottom button.
  Future<void> shareLiveLocation() async {
    // TODO: wire to share_plus or your deep-link share flow.
  }

  /// Called from the SOS bottom button.
  Future<void> triggerSos() async {
    // TODO: wire to your emergency/SOS API.
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }
}