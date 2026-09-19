import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_constant.dart';
import '../../services/auth_services.dart';

class ProfileProvider extends ChangeNotifier {
  // ---------------- User info ----------------
  String name = 'Passenger';
  String verifiedIdLabel = 'Verified Account';
  String email = 'passenger@sajilobus.np';
  String phone = '+977 9801234567';
  String avatarUrl =
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&q=80';

  // ---------------- Transit card ----------------
  String transitCardTitle = 'KOSHI TRANSIT CARD';
  String cardStatus = 'ACTIVE';
  String cardNumber = 'NP-8894';
  String currentBalance = 'NPR 350';

  // ---------------- Emergency safety circle ----------------
  int trustedContactsCount = 2;

  // ---------------- Authentication & security log ----------------
  String sessionState = 'Live Session';
  String lastLogin = 'Today, Active';
  String terminalRegionStatus = 'SUCCESS';
  String terminalRegion = 'Biratnagar';
  String sessionDevice = 'Mobile App (Android/iOS)';
  String firebaseAuthUid = '#usr_sajilobus_active';

  // ---------------- App & travel preferences ----------------
  bool pushNotifications = true;
  bool isEnglish = true;
  bool highContrastMode = true;
  bool audioAnnouncements = true;

  // ---------------- Help & official transit desk ----------------
  String helplineLabel = 'Transit Helpline';
  String helplineNumber = 'Toll-Free 103 / 021-524100';
  String privacyPolicyLabel = 'Privacy Policy & Terms of Carriage';

  // ---------------- App info ----------------
  String appFooter = 'SajiloBus Transit • App Version 3.4.1';

  final AuthService _authService = AuthService();

  ProfileProvider() {
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");

      if (token != null && token.isNotEmpty) {
        final res = await _authService.getMe(token);
        if (res.statusCode == 200 && res.data["success"] == true) {
          final user = res.data["user"];
          if (user != null) {
            name = user["name"] ?? name;
            email = user["email"] ?? email;
            phone = user["phone"] ?? phone;
            firebaseAuthUid = user["firebaseUid"] ?? firebaseAuthUid;
          }
        }
      }
    } catch (e) {
      debugPrint("Error loading passenger profile: $e");
    } finally {
      notifyListeners();
    }
  }

  void togglePushNotifications(bool value) {
    pushNotifications = value;
    notifyListeners();
  }

  void setLanguage(bool english) {
    isEnglish = english;
    notifyListeners();
  }

  void toggleHighContrastMode(bool value) {
    highContrastMode = value;
    notifyListeners();
  }

  void toggleAudioAnnouncements(bool value) {
    audioAnnouncements = value;
    notifyListeners();
  }

  Future<bool> submitFeedback({
    required double rating,
    required String category,
    required String comment,
  }) async {
    try {
      final dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");

      final bodyComment = comment.trim().isEmpty ? 'General feedback submitted via mobile app' : comment.trim();

      final response = await dio.post(
        '${ApiConstant.baseUrl}/feedback',
        data: {
          'name': name,
          'email': email,
          'rating': rating,
          'category': category,
          'comment': bodyComment,
        },
        options: Options(
          headers: (token != null && token.isNotEmpty)
              ? {'Authorization': 'Bearer $token'}
              : {},
        ),
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      if (e is DioException) {
        debugPrint("Error submitting feedback: ${e.response?.statusCode} ${e.response?.data}");
      } else {
        debugPrint("Error submitting feedback: $e");
      }
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}