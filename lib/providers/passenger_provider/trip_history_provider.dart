import 'package:flutter/material.dart';

/// =========================================================
/// MODELS
/// =========================================================

/// A fully expanded trip card (the "Yesterday" trip).
class TripRecord {
  final String routeName; // Route 12B
  final String timeRange; // 08:30 AM – 09:18 AM
  final bool verifiedTicket;

  final String boardingStop; // Biratnagar Bus Park
  final String boardingNote; // Boarded Platform 3
  final String dropStop; // Itahari Central Terminal
  final String dropNote; // Arrived safely at Bay A

  final String distance; // 24.5 km
  final String duration; // 48 mins
  final String avgSpeed; // 32 km/h

  final String busPlate; // BA 2 KHA 8492
  final String busName; // Koshi Super Express
  final String fare; // NPR 45
  final String paymentMethod; // eSewa

  final int stopCount; // 6
  final String scheduleStatus; // On Schedule
  final List<String> stopsEnRoute;

  const TripRecord({
    required this.routeName,
    required this.timeRange,
    required this.verifiedTicket,
    required this.boardingStop,
    required this.boardingNote,
    required this.dropStop,
    required this.dropNote,
    required this.distance,
    required this.duration,
    required this.avgSpeed,
    required this.busPlate,
    required this.busName,
    required this.fare,
    required this.paymentMethod,
    required this.stopCount,
    required this.scheduleStatus,
    required this.stopsEnRoute,
  });
}

/// A compact trip row (the "Earlier this week" list).
class CompactTrip {
  final String routeName; // Route 07
  final String dateTime; // 21 Oct • 05:15 PM – 05:55 PM
  final String fare; // NPR 35
  final String from; // Itahari
  final String to; // Dharan Clock Tower
  final String distance; // 19.2 km
  final String duration; // 40 mins
  final String plate; // KO 1 KHA 4110

  const CompactTrip({
    required this.routeName,
    required this.dateTime,
    required this.fare,
    required this.from,
    required this.to,
    required this.distance,
    required this.duration,
    required this.plate,
  });
}

/// =========================================================
/// PROVIDER
/// =========================================================
class P_TripHistoryProvider extends ChangeNotifier {
  // ---------- Header ----------
  String get brandName => "NVTS TRANSIT";
  String get screenTitle => "Track";
  int get unreadAlerts => 1;
  String get avatarUrl => "https://i.pravatar.cc/100?img=47";

  // ---------- Search ----------
  final TextEditingController searchController = TextEditingController();
  String _query = "";
  String get query => _query;

  void onSearchChanged(String value) {
    _query = value;
    notifyListeners();
  }

  // ---------- Filter chips ----------
  final List<String> filters = const [
    "Today",
    "This Week",
    "This Month",
    "Custom",
  ];

  int _selectedFilter = 1; // "This Week" selected in the design
  int get selectedFilter => _selectedFilter;

  void selectFilter(int index) {
    _selectedFilter = index;
    notifyListeners();
  }

  // ---------- Commute summary ----------
  String get summaryLabel => "COMMUTE SUMMARY";
  String get summaryTitle => "Weekly Overview";
  String get co2Saved => "12.4 kg CO₂ saved";

  String get totalTrips => "14";
  String get totalTripsDelta => "+2";
  String get totalDistance => "184";
  String get totalDistanceUnit => "km";
  String get avgCommute => "38";
  String get avgCommuteUnit => "min";

  // ---------- Section headers ----------
  String get yesterdayLabel => "YESTERDAY • 23 OCT";
  String get yesterdayTrailing => "1 Trip Completed";
  String get earlierLabel => "EARLIER THIS WEEK";
  String get earlierTrailing => "2 Trips";

  // ---------- Yesterday trip ----------
  final TripRecord yesterdayTrip = const TripRecord(
    routeName: "Route 12B",
    timeRange: "08:30 AM – 09:18 AM",
    verifiedTicket: true,
    boardingStop: "Biratnagar Bus Park",
    boardingNote: "Boarded Platform 3",
    dropStop: "Itahari Central Terminal",
    dropNote: "Arrived safely at Bay A",
    distance: "24.5 km",
    duration: "48 mins",
    avgSpeed: "32 km/h",
    busPlate: "BA 2 KHA 8492",
    busName: "Koshi Super Express",
    fare: "NPR 45",
    paymentMethod: "eSewa",
    stopCount: 6,
    scheduleStatus: "On Schedule",
    stopsEnRoute: [
      "Bargachhi",
      "Tankisinuwari",
      "Duhabi",
      "Khanar Chowk",
      "Itahari",
    ],
  );

  // ---------- Earlier trips ----------
  final List<CompactTrip> earlierTrips = const [
    CompactTrip(
      routeName: "Route 07",
      dateTime: "21 Oct • 05:15 PM – 05:55 PM",
      fare: "NPR 35",
      from: "Itahari",
      to: "Dharan Clock Tower",
      distance: "19.2 km",
      duration: "40 mins",
      plate: "KO 1 KHA 4110",
    ),
    CompactTrip(
      routeName: "Route 18",
      dateTime: "19 Oct • 02:00 PM – 03:15 PM",
      fare: "NPR 70",
      from: "Dharan",
      to: "Biratnagar Border",
      distance: "46.0 km",
      duration: "1h 15m",
      plate: "NA 4 KHA 1209",
    ),
  ];

  // ---------- Reward banner ----------
  String get rewardTitle => "Regular Rider Level 3";
  String get rewardSubtitle => "3 more trips this month for 10% cash rebate!";

  // ---------- Actions ----------
  void openFilterSheet() {}

  void openNotifications() {}

  void openProfile() {}

  void expandMap(TripRecord trip) {}

  void viewReceipt(TripRecord trip) {}

  void bookAgain(TripRecord trip) {}

  void openTripDetail(CompactTrip trip) {}

  void openRewards() {}

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}