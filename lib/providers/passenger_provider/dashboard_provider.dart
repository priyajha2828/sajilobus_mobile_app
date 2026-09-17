import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:sajilo_bus/routes/app_route.dart';

import '../../main.dart';

/// A quick-destination pill chip under the search bar.
class QuickDestination {
  final IconData icon;
  final String label;

  const QuickDestination({required this.icon, required this.label});
}

/// Data behind the dark "ROUTE #104 / Daily Commute" promo card.
class RoutePromoData {
  final String routeNumber; // "ROUTE #104"
  final String tag; // "DAILY COMMUTE"
  final String fare; // "NPR 45"
  final String stopName; // "Biratnagar Bus Park"
  final String etaLabel; // "Next bus departure in 4 mins away"
  final String fromStop;
  final String toStop;

  /// 0.0 – 1.0 position of the bus along the route.
  final double progress;

  const RoutePromoData({
    required this.routeNumber,
    required this.tag,
    required this.fare,
    required this.stopName,
    required this.etaLabel,
    required this.fromStop,
    required this.toStop,
    required this.progress,
  });
}

/// One tile in the "Quick Transit Hub" grid.
class QuickAction {
  final IconData icon;
  final String label;
  final bool isHighlighted; // SOS Panic gets high-alert styling
  final int? badgeCount; // e.g. Alerts -> 2
  final VoidCallback? onTap;

  const QuickAction({
    required this.icon,
    required this.label,
    this.isHighlighted = false,
    this.badgeCount,
    this.onTap,
  });
}

/// Live-tracking status for a nearby bus.
enum BusStatus { active, maintenance }

/// One nearby real-time bus card.
class LiveBus {
  final String plateNumber;
  final BusStatus status;
  final String routeTitle;

  /// e.g. "3" paired with [etaUnit] "MINS AWAY", or "22" with "DELAYED".
  final String etaValue;
  final String etaUnit;

  final String? nearestStop;
  final String? nearestStopDistance;

  final int? capacityCurrent;
  final int? capacityMax;
  final String? capacityNote; // "Few Seats Left" / "Spacious"

  /// Shown instead of capacity/stop rows for a maintenance bus.
  final String? warningText;

  final bool isTrackable;

  const LiveBus({
    required this.plateNumber,
    required this.status,
    required this.routeTitle,
    required this.etaValue,
    required this.etaUnit,
    this.nearestStop,
    this.nearestStopDistance,
    this.capacityCurrent,
    this.capacityMax,
    this.capacityNote,
    this.warningText,
    this.isTrackable = true,
  });

  double? get capacityPercent =>
      (capacityCurrent != null && capacityMax != null && capacityMax! > 0)
          ? capacityCurrent! / capacityMax!
          : null;
}

class TransitHomeProvider extends ChangeNotifier {
  // ---------------- Top bar / greeting ----------------
  final String appName = 'NVTS TRANSIT';
  final String pageLabel = 'Home';
  final int notificationCount = 1;
  final String userName = 'Sita Rai';
  final bool isGpsSynced = true;
  final String dateLabel = 'Tuesday, 24 October';
  final String locationLabel = 'Biratnagar Metropolitan';

  // ---------------- Search ----------------
  final TextEditingController searchController = TextEditingController();

  void updateSearch(String value) {
    notifyListeners();
  }

  void startVoiceSearch() {
    // TODO: integrate voice search.
    notifyListeners();
  }

  final List<QuickDestination> quickDestinations = const [
    QuickDestination(icon: Icons.near_me_outlined, label: 'Itahari Chowk'),
    QuickDestination(icon: Icons.directions_bus_outlined, label: 'Dharan Bus Park'),
    QuickDestination(icon: Icons.location_city_outlined, label: 'Biratnagar Airport'),
  ];

  void selectDestination(String label) {
    searchController.text = label;
    notifyListeners();
  }

  // ---------------- Route promo card ----------------
  final RoutePromoData routePromo = const RoutePromoData(
    routeNumber: 'ROUTE #104',
    tag: 'DAILY COMMUTE',
    fare: 'NPR 45',
    stopName: 'Biratnagar Bus Park',
    etaLabel: 'Next bus departure in 4 mins away',
    fromStop: 'Biratnagar Stn',
    toStop: 'Itahari Chowk',
    progress: 0.42,
  );

  void quickTrackRoute() {
    // TODO: navigate to live route tracking.
    notifyListeners();
  }

  // ---------------- Quick Transit Hub ----------------
  final List<QuickAction> quickActions = [
    QuickAction(icon: Icons.map_outlined, label: 'Track Bus',),
    QuickAction(icon: Icons.alt_route, label: 'Search Route',onTap: () => navigatorKey.currentState?.pushNamed(AppRoute.trackbus)),
    QuickAction(icon: Icons.notifications_none_rounded, label: 'Alerts', badgeCount: 2,onTap: () => navigatorKey.currentState?.pushNamed(AppRoute.alert)),
    QuickAction(icon: Icons.sos_rounded, label: 'SOS Panic', isHighlighted: true,onTap: () => navigatorKey.currentState?.pushNamed(AppRoute.p_sos)),
    QuickAction(icon: Icons.history_outlined, label: 'Trip Log',onTap: () => navigatorKey.currentState?.pushNamed(AppRoute.p_triphistory)),
    QuickAction(icon: Icons.shield_outlined, label: 'Contacts',onTap: () => navigatorKey.currentState?.pushNamed(AppRoute.sos_contact)
    ),
  ];

  void openQuickAction(String label) {
    // TODO: route to the matching feature screen.
    notifyListeners();
  }

  // ---------------- Live Highway Radar ----------------
  final String radarActiveLabel = '3 Active in Bargachhi Sector';
  final String radarHighwayLabel = 'Koshi Rajmarg • High Density';
  final String radarSpeedLabel = 'Speed avg 38 km/h';

  void expandMap() {
    // TODO: navigate to the full-screen live map.
    notifyListeners();
  }

  void recenterRadar() {
    // TODO: recenter the map on the user's location.
    notifyListeners();
  }

  // ---------------- Nearby real-time buses ----------------
  final String nearbySubtitle = 'Live telematics around Bargachhi & Rani';

  final List<LiveBus> nearbyBuses = const [
    LiveBus(
      plateNumber: 'BA 2 KHA 8492',
      status: BusStatus.active,
      routeTitle: 'Biratnagar - Itahari Express',
      etaValue: '3',
      etaUnit: 'MINS AWAY',
      nearestStop: 'Bargachhi',
      nearestStopDistance: '120m away',
      capacityCurrent: 32,
      capacityMax: 40,
      capacityNote: 'Few Seats Left',
    ),
    LiveBus(
      plateNumber: 'KO 1 KHA 5521',
      status: BusStatus.active,
      routeTitle: 'Dharan - Biratnagar Direct',
      etaValue: '9',
      etaUnit: 'MINS AWAY',
      nearestStop: 'Rani Chowk',
      nearestStopDistance: '450m away',
      capacityCurrent: 18,
      capacityMax: 40,
      capacityNote: 'Spacious',
    ),
    LiveBus(
      plateNumber: 'PR 01-002 KHA 3109',
      status: BusStatus.maintenance,
      routeTitle: 'Koshi Highway Shuttle',
      etaValue: '22',
      etaUnit: 'DELAYED',
      warningText: 'Temporary inspection at Depot 4',
      capacityCurrent: 0,
      capacityMax: 40,
      isTrackable: false,
    ),
  ];

  void trackBus(String plateNumber) {
    // TODO: open live tracking for this bus.
    notifyListeners();
  }

  final Set<String> bookmarkedBuses = {};

  void toggleBookmark(String plateNumber) {
    if (bookmarkedBuses.contains(plateNumber)) {
      bookmarkedBuses.remove(plateNumber);
    } else {
      bookmarkedBuses.add(plateNumber);
    }
    notifyListeners();
  }

  void openNotifications() {
    // TODO: navigate to the notifications screen.
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}