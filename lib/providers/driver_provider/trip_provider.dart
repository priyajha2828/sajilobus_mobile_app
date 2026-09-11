import 'package:flutter/material.dart';

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

/// Holds all state for the "Active Route" trip screen and exposes the
/// actions the driver can take (reached stop / skip stop / emergency).
class TripProvider extends ChangeNotifier {
  // Header / status
  bool driverOnline = true;
  bool liveGpsOn = true;

  // Route summary
  String originCity = 'Biratnagar';
  String destinationCity = 'Itahari';
  String roadName = 'Koshi Highway Express';
  String routeCode = 'बा २ ख ५४५६'; // vehicle / permit code shown top-right

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

  final List<RouteStop> stops = [
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

  /// Marks the current stop as completed and advances to the next one.
  void markReachedStop() {
    final currentIdx = stops.indexWhere((s) => s.status == StopStatus.current);
    if (currentIdx == -1) return;

    stops[currentIdx].status = StopStatus.completed;

    final nextIdx = currentIdx + 1;
    if (nextIdx < stops.length) {
      // Don't turn the terminus into "current"; only intermediate stops.
      if (stops[nextIdx].status == StopStatus.upcoming) {
        stops[nextIdx].status = StopStatus.current;
        currentStopIndex = stops[nextIdx].index;
      }
      if (stopsRemaining > 0) stopsRemaining--;
    }
    notifyListeners();
  }

  /// Skips the current stop without marking it as boarded/exited.
  void skipStop() {
    final currentIdx = stops.indexWhere((s) => s.status == StopStatus.current);
    if (currentIdx == -1) return;

    stops[currentIdx].status = StopStatus.completed;
    final nextIdx = currentIdx + 1;
    if (nextIdx < stops.length && stops[nextIdx].status == StopStatus.upcoming) {
      stops[nextIdx].status = StopStatus.current;
      currentStopIndex = stops[nextIdx].index;
    }
    if (stopsRemaining > 0) stopsRemaining--;
    notifyListeners();
  }

  /// Triggers the emergency / SOS flow. Hook this up to your alerting
  /// backend or call-out flow.
  void triggerEmergency() {
    // TODO: wire this to your actual emergency/SOS backend call.
    debugPrint('EMERGENCY triggered for route $originCity → $destinationCity');
    notifyListeners();
  }

  void updateSpeed(int speed) {
    currentSpeed = speed;
    notifyListeners();
  }
}