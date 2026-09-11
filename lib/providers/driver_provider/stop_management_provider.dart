import 'package:flutter/material.dart';


enum WaypointStatus { completed, active, upcoming, finalDestination }

/// A single stop in the corridor timeline.
class WaypointModel {
  final int index;
  final String name;
  final String timeLabel; // e.g. "08:30 AM" or "ETA 09:47 AM"
  final WaypointStatus status;

  /// e.g. "+22 Boarded" / "+8 Boarded"
  final int? boarded;

  /// e.g. "0 Dropped" / "-3 Dropped" (store as positive count)
  final int? dropped;

  /// e.g. "12 Waiting" / "15 Waiting"
  final int? waiting;

  /// e.g. "7 Pre-booked"
  final int? prebooked;

  const WaypointModel({
    required this.index,
    required this.name,
    required this.timeLabel,
    required this.status,
    this.boarded,
    this.dropped,
    this.waiting,
    this.prebooked,
  });

  WaypointModel copyWith({
    String? timeLabel,
    WaypointStatus? status,
    int? boarded,
    int? dropped,
    int? waiting,
  }) {
    return WaypointModel(
      index: index,
      name: name,
      timeLabel: timeLabel ?? this.timeLabel,
      status: status ?? this.status,
      boarded: boarded ?? this.boarded,
      dropped: dropped ?? this.dropped,
      waiting: waiting ?? this.waiting,
      prebooked: prebooked,
    );
  }
}

class StopManagementProvider extends ChangeNotifier {
  // ---------------- Header / route meta ----------------
  final String lineLabel = 'LINE 1 • TERMINAL CONTROL';
  final String corridorName = 'Koshi Highway Express Corridor';
  final String routeArea = 'Biratnagar-Itahari';
  final String busPlate = 'बा २ ख ४४६६';
  final String busNumber = 'BUS #104';
  final bool isOnline = true;

  // ---------------- Current stop ----------------
  int currentStopIndex = 3;
  int totalStops = 6;
  String stopName = 'Mahendra Chowk';
  String stopSubLocation = 'Biratnagar Hub • Ward 9 Crossing';
  String currentTime = '09:41';
  int scheduleDeltaMinutes = 2; // positive = ahead / on schedule
  bool isLiveGeoFenced = true;

  // ---------------- Occupancy ----------------
  int occupancyCurrent = 37;
  int occupancyMax = 40;

  double get occupancyPercent =>
      occupancyMax == 0 ? 0 : occupancyCurrent / occupancyMax;

  int get occupancyPercentInt => (occupancyPercent * 100).round();

  // ---------------- Stop counters ----------------
  int waitingCount = 12;
  int boardedDelta = 8;
  int droppedDelta = 3;

  // ---------------- Next stop ----------------
  final String nextStopName = 'Tankisinuwari Bus Stand';
  final String nextStopSub = 'Industrial Corridor Gate • Biratnagar North';
  final double nextStopDistanceKm = 2.5;
  final int nextStopEtaMinutes = 6;
  final int nextStopStage = 4;
  final int prebookedTickets = 7;

  // ---------------- Control room ----------------
  final String controlRoomName = 'Biratnagar Control Room';
  final String controlRoomSub = 'Direct Dispatch Hotline';

  // ---------------- Corridor timeline ----------------
  final List<WaypointModel> waypoints = [
    const WaypointModel(
      index: 1,
      name: 'Biratnagar Bus Park',
      timeLabel: '08:30 AM',
      status: WaypointStatus.completed,
      boarded: 22,
      dropped: 0,
    ),
    const WaypointModel(
      index: 2,
      name: 'Traffic Chowk',
      timeLabel: '08:50 AM',
      status: WaypointStatus.completed,
      boarded: 5,
      dropped: 2,
    ),
    const WaypointModel(
      index: 3,
      name: 'Mahendra Chowk',
      timeLabel: 'ACTIVE NOW',
      status: WaypointStatus.active,
      boarded: 8,
      dropped: 3,
      waiting: 12,
    ),
    const WaypointModel(
      index: 4,
      name: 'Tankisinuwari',
      timeLabel: 'ETA 09:47 AM',
      status: WaypointStatus.upcoming,
      prebooked: 7,
    ),
    const WaypointModel(
      index: 5,
      name: 'Duhabi Bazar',
      timeLabel: 'ETA 10:05 AM',
      status: WaypointStatus.upcoming,
      waiting: 15,
    ),
    const WaypointModel(
      index: 6,
      name: 'Itahari Central Bus Terminal',
      timeLabel: 'ETA 10:30 AM',
      status: WaypointStatus.finalDestination,
    ),
  ];

  // ---------------- Actions ----------------
  void incrementBoarded() {
    boardedDelta++;
    if (occupancyCurrent < occupancyMax) occupancyCurrent++;
    notifyListeners();
  }

  void decrementBoarded() {
    if (boardedDelta > 0) boardedDelta--;
    if (occupancyCurrent > 0) occupancyCurrent--;
    notifyListeners();
  }

  void incrementDropped() {
    droppedDelta++;
    if (occupancyCurrent > 0) occupancyCurrent--;
    notifyListeners();
  }

  void decrementDropped() {
    if (droppedDelta > 0) droppedDelta--;
    if (occupancyCurrent < occupancyMax) occupancyCurrent++;
    notifyListeners();
  }

  /// Confirms boarding for the current stop and advances the route.
  void departStopAndConfirmBoarding() {
    // Reset per-stop counters after departure; wire this up to your
    // actual API / dispatch call as needed.
    waitingCount = 0;
    boardedDelta = 0;
    droppedDelta = 0;
    if (currentStopIndex < totalStops) {
      currentStopIndex++;
    }
    notifyListeners();
  }

  /// Hook this up to your SMS / App beacon notification service.
  void notifyWaitingPassengers() {
    // TODO: integrate with SMS / push notification service.
    notifyListeners();
  }

  void triggerSOS() {
    // TODO: integrate with dispatch hotline / emergency service.
    notifyListeners();
  }
}