import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sajilo_bus/config/dio_client.dart';
import '../../services/driver_service.dart';

class DriverDashboardProvider extends ChangeNotifier {
  bool _driverOnline = true;
  bool _isLoading = false;

  Map<String, dynamic>? _activeTrip;
  Map<String, dynamic>? _busAssignment;
  Map<String, dynamic>? _driverProfile;

  // Dynamic Dashboard State
  String noticeTitle = "Koshi Corridor Alert:";
  String noticeMessage = "Notice: Koshi Highway road expansion near Duhabi — expect ~10 min slow crawl.";

  int occupiedSeats = 32;
  int capacity = 40;
  String get loadPercentageNote => capacity > 0 ? "${((occupiedSeats / capacity) * 100).round()}% Loaded" : "Loaded";

  int liveSpeedKmh = 42;
  String liveDirection = "North";
  String liveLocation = "Mahendra Chowk, Biratnagar Sector";

  String activeTripId = "882";
  String nextStopName = "Duhabi Bazar Halt";
  String etaText = "09:54 AM";
  String distanceRemainingText = "3.2 km";

  int eTickets = 28;
  int cashBoardings = 4;

  List<Map<String, dynamic>> stops = [
    {"name": "Biratnagar Terminal", "time": "09:15"},
    {"name": "Duhabi", "time": "09:54"},
    {"name": "Itahari", "time": "10:30"},
  ];

  bool get driverOnline => _driverOnline;
  bool get isLoading => _isLoading;
  Map<String, dynamic>? get activeTrip => _activeTrip;
  Map<String, dynamic>? get busAssignment => _busAssignment;
  Map<String, dynamic>? get driverProfile => _driverProfile;

  final DriverService _driverService = DriverService();

  DriverDashboardProvider() {
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");

      final options = (token != null && token.isNotEmpty)
          ? Options(headers: {"Authorization": "Bearer $token"})
          : null;

      final dashRes = await DioClient.dio.get("/driver-profile/dashboard", options: options);

      if (dashRes.statusCode == 200 && dashRes.data["success"] == true) {
        final dash = dashRes.data["dashboard"];
        if (dash != null) {
          if (dash["driver"] != null) {
            _driverProfile = dash["driver"];
            _driverOnline = dash["driver"]["isAvailable"] ?? true;
          }

          if (dash["occupancy"] != null) {
            occupiedSeats = dash["occupancy"]["occupiedSeats"] ?? occupiedSeats;
            capacity = dash["occupancy"]["totalSeats"] ?? capacity;
          }

          if (dash["speed"] != null) {
            liveSpeedKmh = dash["speed"]["kmh"] ?? liveSpeedKmh;
            liveDirection = dash["speed"]["direction"] ?? liveDirection;
            liveLocation = dash["speed"]["location"] ?? liveLocation;
          }

          if (dash["activeTrip"] != null) {
            _activeTrip = dash["activeTrip"];
            activeTripId = dash["activeTrip"]["id"]?.toString() ?? activeTripId;
            nextStopName = dash["activeTrip"]["nextStopName"] ?? nextStopName;
            etaText = dash["activeTrip"]["eta"] ?? etaText;
            distanceRemainingText = dash["activeTrip"]["distanceRemaining"] ?? distanceRemainingText;
          }

          if (dash["notice"] != null) {
            noticeTitle = dash["notice"]["title"] ?? noticeTitle;
            noticeMessage = dash["notice"]["message"] ?? noticeMessage;
          }

          if (dash["ticketing"] != null) {
            eTickets = dash["ticketing"]["eTickets"] ?? eTickets;
            cashBoardings = dash["ticketing"]["cashBoardings"] ?? cashBoardings;
          }

          if (dash["stops"] != null && (dash["stops"] as List).isNotEmpty) {
            stops = List<Map<String, dynamic>>.from(dash["stops"]);
          }
        }
      }
    } on DioException catch (e) {
      debugPrint("Dashboard data load error: ${e.response?.data}");
    } catch (e) {
      debugPrint("Dashboard fetch error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleDriverState() async {
    _driverOnline = !_driverOnline;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");
      if (token != null) {
        await _driverService.toggleAvailability(token, _driverOnline);
      }
    } catch (e) {
      debugPrint("Error toggling status: $e");
    }
  }
}