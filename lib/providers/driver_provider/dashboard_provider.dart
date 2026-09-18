import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/driver_service.dart';

class DriverDashboardProvider extends ChangeNotifier {
  bool _driverOnline = true;
  bool _isLoading = false;

  Map<String, dynamic>? _activeTrip;
  Map<String, dynamic>? _busAssignment;
  Map<String, dynamic>? _driverProfile;

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

      if (token != null && token.isNotEmpty) {
        final profileRes = await _driverService.getProfile(token);
        if (profileRes.statusCode == 200 && profileRes.data["success"] == true) {
          final data = profileRes.data["driver"];
          _driverProfile = data;
          _driverOnline = data["isAvailable"] ?? true;
          _activeTrip = data["activeTrip"];
          _busAssignment = data["assignment"];
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