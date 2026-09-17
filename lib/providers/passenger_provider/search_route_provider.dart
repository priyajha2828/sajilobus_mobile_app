import 'package:flutter/material.dart';

/// A single live/scheduled bus shown inside a [TransitRoute] card.
class RouteBus {
  final String plate;
  final String etaLabel; // e.g. "3 min"
  final bool isUrgent; // highlights the eta pill in green when arriving soon

  const RouteBus({
    required this.plate,
    required this.etaLabel,
    this.isUrgent = false,
  });
}

/// Model for a single transit route card (e.g. LINE 104, LINE 208).
class TransitRoute {
  final String lineLabel; // "LINE 104"
  final String? tagLabel; // "Frequent Service" or "Regional Transit"
  final bool tagIsLive; // true => green dot + green tag styling
  final String title; // "Biratnagar → Itahari Express"
  final String durationLabel; // "42" / "1"
  final String durationUnit; // "m" / "h"
  final String? extraDurationLabel; // "15" for the "1h 15m" style split
  final String? extraDurationUnit; // "m"
  final String distanceLabel; // "24.5 km" / "46.0 km"
  final String fromStop;
  final String toStop;
  final String busCountLabel; // "6 buses currently en-route" / "4 buses in service"
  final bool showGpsActive;
  final List<RouteBus> liveBuses;
  final int moreBusesCount;
  final String? nextDepartureLabel; // "Next departure: 18 min"
  final String ctaLabel; // "View Route Schedule & Map" / "Route Details"

  const TransitRoute({
    required this.lineLabel,
    this.tagLabel,
    this.tagIsLive = false,
    required this.title,
    required this.durationLabel,
    required this.durationUnit,
    this.extraDurationLabel,
    this.extraDurationUnit,
    required this.distanceLabel,
    required this.fromStop,
    required this.toStop,
    required this.busCountLabel,
    this.showGpsActive = false,
    this.liveBuses = const [],
    this.moreBusesCount = 0,
    this.nextDepartureLabel,
    required this.ctaLabel,
  });
}

/// Model for a single "Nearby Bus Stop" tile.
class NearbyBusStop {
  final String name;
  final String distanceLabel; // "350m away" / "1.2 km away"
  final String walkOrDistanceExtra; // "4 min walk" (optional, appended)
  final String etaLabel; // "6 mins"
  final bool etaSoon; // controls green vs neutral pill
  final String routeLabel; // "Route 104, 107"

  const NearbyBusStop({
    required this.name,
    required this.distanceLabel,
    this.walkOrDistanceExtra = '',
    required this.etaLabel,
    this.etaSoon = false,
    required this.routeLabel,
  });
}

/// Tabs shown under the Journey Planner card.
enum TrackTab { allRoutes, nearbyStops, activeBuses }

class SearchRouteProvider extends ChangeNotifier {
  SearchRouteProvider() {
    fromController.text = fromLocation;
    toController.text = toLocation;
  }

  // ---------------------------------------------------------------------
  // Status strip
  // ---------------------------------------------------------------------
  final String gridLabel = 'Koshi Province Transit Grid';
  final bool isLiveSync = true;

  // ---------------------------------------------------------------------
  // Journey planner
  // ---------------------------------------------------------------------
  String fromLocation = 'Current Location (Biratnaga...';
  String toLocation = 'Itahari Transit Plaza';

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  void swapLocations() {
    final tempText = fromController.text;
    fromController.text = toController.text;
    toController.text = tempText;

    final temp = fromLocation;
    fromLocation = toLocation;
    toLocation = temp;
    notifyListeners();
  }

  void resetJourney() {
    fromLocation = 'Current Location (Biratnaga...';
    toLocation = 'Itahari Transit Plaza';
    fromController.text = fromLocation;
    toController.text = toLocation;
    notifyListeners();
  }

  void clearDestination() {
    toLocation = '';
    toController.clear();
    notifyListeners();
  }

  // ---------------------------------------------------------------------
  // Tabs
  // ---------------------------------------------------------------------
  TrackTab selectedTab = TrackTab.allRoutes;

  int get allRoutesCount => routes.length;
  final int nearbyStopsCount = 8;

  void selectTab(TrackTab tab) {
    selectedTab = tab;
    notifyListeners();
  }

  // ---------------------------------------------------------------------
  // Direct transit routes
  // ---------------------------------------------------------------------
  final List<TransitRoute> routes = const [
    TransitRoute(
      lineLabel: 'LINE 104',
      tagLabel: 'Frequent Service',
      tagIsLive: true,
      title: 'Biratnagar → Itahari Express',
      durationLabel: '42',
      durationUnit: 'm',
      distanceLabel: '24.5 km',
      fromStop: 'Biratnagar Central',
      toStop: 'Itahari Chowk',
      busCountLabel: '6 buses currently en-route',
      showGpsActive: true,
      liveBuses: [
        RouteBus(plate: 'BA 2 KHA 8492', etaLabel: '3 min', isUrgent: true),
        RouteBus(plate: 'KO 1 KHA 4110', etaLabel: '12 min'),
      ],
      moreBusesCount: 4,
      ctaLabel: 'View Route Schedule & Map',
    ),
    TransitRoute(
      lineLabel: 'LINE 208',
      tagLabel: 'Regional Transit',
      tagIsLive: false,
      title: 'Dharan Ghantaghar → Biratnagar',
      durationLabel: '1',
      durationUnit: 'h',
      extraDurationLabel: '15',
      extraDurationUnit: 'm',
      distanceLabel: '46.0 km',
      fromStop: 'Dharan Ghantaghar',
      toStop: 'Biratnagar Border Gate',
      busCountLabel: '4 buses in service',
      nextDepartureLabel: 'Next departure: 18 min',
      ctaLabel: 'Route Details',
    ),
  ];

  // ---------------------------------------------------------------------
  // Nearby bus stops
  // ---------------------------------------------------------------------
  final List<NearbyBusStop> nearbyStops = const [
    NearbyBusStop(
      name: 'Tankisinuwari Bus Stop',
      distanceLabel: '350m away',
      walkOrDistanceExtra: '4 min walk',
      etaLabel: '6 mins',
      etaSoon: true,
      routeLabel: 'Route 104, 107',
    ),
    NearbyBusStop(
      name: 'Duhabi Bazaar Stop',
      distanceLabel: '1.2 km away',
      etaLabel: '11 mins',
      routeLabel: 'Route 104, 208',
    ),
    NearbyBusStop(
      name: 'Khanar Chowk',
      distanceLabel: '2.8 km away',
      etaLabel: '15 mins',
      routeLabel: 'Route 104 Express',
    ),
  ];

  // ---------------------------------------------------------------------
  // Actions (hook these up to real navigation / map / API calls)
  // ---------------------------------------------------------------------
  void viewRouteSchedule(TransitRoute route) {
    // TODO: navigate to route schedule & map screen
  }

  void openRouteDetails(TransitRoute route) {
    // TODO: navigate to route details screen
  }

  void openStop(NearbyBusStop stop) {
    // TODO: navigate to stop details screen
  }

  void openLiveRadar() {
    // TODO: navigate to live radar screen
  }

  void useCurrentLocationForPickup() {
    // TODO: fetch device GPS and update fromLocation
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }
}