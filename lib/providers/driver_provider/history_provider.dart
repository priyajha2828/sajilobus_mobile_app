import 'package:flutter/material.dart';

import '../../resources/color/custom_color.dart';


/// One tile in the 2x2 summary stats grid (Trips Logged, Distance, etc).
class SummaryStat {
  final IconData icon;
  final Color accent;
  final String label;
  final String value;
  final String? unit;
  final String subtext;

  const SummaryStat({
    required this.icon,
    required this.accent,
    required this.label,
    required this.value,
    required this.subtext,
    this.unit,
  });
}

/// One end (origin or destination) of a trip's route timeline.
class ManifestPoint {
  final String label; // e.g. "ORIGIN TERMINAL"
  final String name; // e.g. "Biratnagar Bus Park"
  final String time; // e.g. "06:00 AM"

  const ManifestPoint({
    required this.label,
    required this.name,
    required this.time,
  });
}

/// The fully-expanded, most-recent manifest card at the top of the list.
class DetailedManifest {
  final String tripId;
  final String dateShift; // "Today • Shift 1"
  final String statusLabel; // "COMPLETED"
  final String plateNumber;
  final String busType;
  final String tripLogId;
  final ManifestPoint origin;
  final ManifestPoint destination;
  final String duration;
  final String distance;
  final String avgSpeed;
  final String stopsCoveredLabel; // "8 Stops Covered (All on-time)"
  final String loadLabel; // "38/40"
  final String highwayLabel; // "Koshi Highway NH-08"
  final String routeLogLabel; // "Verified Route Log"
  final String maxSpeedLabel; // "MAX 52 KM/H"

  const DetailedManifest({
    required this.tripId,
    required this.dateShift,
    required this.statusLabel,
    required this.plateNumber,
    required this.busType,
    required this.tripLogId,
    required this.origin,
    required this.destination,
    required this.duration,
    required this.distance,
    required this.avgSpeed,
    required this.stopsCoveredLabel,
    required this.loadLabel,
    required this.highwayLabel,
    required this.routeLogLabel,
    required this.maxSpeedLabel,
  });
}

/// A collapsed/compact manifest row lower in the list.
class CompactManifest {
  final String tripId;
  final String dateLabel;
  final String statusLabel;
  final String routeTitle; // "Dharan → Biratnagar"
  final String distanceLogged; // "42.5 km logged"
  final String timeRangeSubtitle;
  final IconData leftIcon;
  final String leftLabel; // "40 Riders (Full)"
  final IconData midIcon;
  final String midLabel; // "1h 50m"

  const CompactManifest({
    required this.tripId,
    required this.dateLabel,
    required this.statusLabel,
    required this.routeTitle,
    required this.distanceLogged,
    required this.timeRangeSubtitle,
    required this.leftIcon,
    required this.leftLabel,
    required this.midIcon,
    required this.midLabel,
  });
}
class TripManifestProvider extends ChangeNotifier {
  // ---------------- Search ----------------
  final TextEditingController searchController = TextEditingController();

  void updateSearch(String value) {
    notifyListeners();
  }

  void openFilters() {
    // TODO: open advanced filter sheet.
    notifyListeners();
  }

  // ---------------- Date range filter tabs ----------------
  final List<String> filterTabs = const ['Today', 'This Week', 'This Month', 'Custom'];
  int selectedFilterIndex = 0;

  void selectFilter(int index) {
    selectedFilterIndex = index;
    notifyListeners();
  }

  // ---------------- Summary stats (2x2 grid) ----------------
  final List<SummaryStat> stats = const [
    SummaryStat(
      icon: Icons.local_shipping_outlined,
      accent: CustomColor.statBlue,
      label: 'TRIPS LOGGED',
      value: '3',
      unit: 'Completed',
      subtext: 'Shift: Day Run A-1',
    ),
    SummaryStat(
      icon: Icons.speed_outlined,
      accent: CustomColor.statPurple,
      label: 'DISTANCE',
      value: '84.6',
      unit: 'km',
      subtext: '+12% target',
    ),
    SummaryStat(
      icon: Icons.groups_outlined,
      accent: CustomColor.statTeal,
      label: 'PASSENGERS',
      value: '108',
      unit: 'riders',
      subtext: '90% Load capacity',
    ),
    SummaryStat(
      icon: Icons.access_time_filled_outlined,
      accent: CustomColor.statGreen,
      label: 'ON-TIME RATE',
      value: '96.4%',
      subtext: 'Transit corridor K-01',
    ),
  ];

  // ---------------- Verified manifests ----------------
  final int totalLogs = 3;
  String sortByLabel = 'Sort by';

  final DetailedManifest featuredManifest = const DetailedManifest(
    tripId: 'TRP-2025-1042',
    dateShift: 'Today • Shift 1',
    statusLabel: 'COMPLETED',
    plateNumber: 'बा २ ख ४५६६',
    busType: 'Isuzu Front-Engine Bus',
    tripLogId: 'Trip Log ID #1042',
    origin: ManifestPoint(
      label: 'ORIGIN TERMINAL',
      name: 'Biratnagar Bus Park',
      time: '06:00 AM',
    ),
    destination: ManifestPoint(
      label: 'DESTINATION HUB',
      name: 'Dharan Bhanu Chowk',
      time: '07:45 AM',
    ),
    duration: '1h 45m',
    distance: '42.5 km',
    avgSpeed: '44 km/h',
    stopsCoveredLabel: '8 Stops Covered (All on-time)',
    loadLabel: '38/40',
    highwayLabel: 'Koshi Highway NH-08',
    routeLogLabel: 'Verified Route Log',
    maxSpeedLabel: 'MAX 52 KM/H',
  );

  final List<CompactManifest> otherManifests = const [
    CompactManifest(
      tripId: 'TRP-2025-1041',
      dateLabel: 'Yesterday, 11 Oct',
      statusLabel: 'COMPLETED',
      routeTitle: 'Dharan → Biratnagar',
      distanceLogged: '42.5 km logged',
      timeRangeSubtitle: '04:00 PM – 05:50 PM • Return Shuttle',
      leftIcon: Icons.groups_outlined,
      leftLabel: '40 Riders (Full)',
      midIcon: Icons.schedule_outlined,
      midLabel: '1h 50m',
    ),
    CompactManifest(
      tripId: 'TRP-2025-1039',
      dateLabel: '11 Oct 2025 • Morning',
      statusLabel: 'COMPLETED',
      routeTitle: 'Biratnagar → Itahari Express',
      distanceLogged: '28.0 km logged',
      timeRangeSubtitle: '08:15 AM – 09:10 AM • Rapid Corridor',
      leftIcon: Icons.groups_outlined,
      leftLabel: '35 Riders',
      midIcon: Icons.speed_outlined,
      midLabel: '48 km/h avg',
    ),
  ];

  // ---------------- Department log / download ----------------
  final String departmentTitle = 'Department of Transport Log';
  final String departmentSubtitle = 'Koshi Province digital compliance record';
  final String downloadButtonLabel = 'Download Monthly Driver Log (PDF / CSV)';
  final String footerNote =
      'Auto-signed cryptographic telematics seal • FleetTrack NP v2.4';

  // ---------------- Actions ----------------
  void viewManifest(String tripId) {
    // TODO: navigate to the full manifest document viewer.
    notifyListeners();
  }

  void shareManifest(String tripId) {
    // TODO: integrate share_plus to export the manifest.
    notifyListeners();
  }

  void openDetails(String tripId) {
    // TODO: navigate to the compact manifest's detail screen.
    notifyListeners();
  }

  void downloadMonthlyLog() {
    // TODO: trigger PDF/CSV export + download.
    notifyListeners();
  }

  void openDepartmentLog() {
    // TODO: open the Department of Transport compliance record.
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}