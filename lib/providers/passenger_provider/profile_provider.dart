import 'package:flutter/material.dart';

/// Holds all the data + toggle state shown on the Profile screen.
///
/// Wrap the app (or just this screen) with:
///   ChangeNotifierProvider(create: (_) => ProfileProvider()),
class ProfileProvider extends ChangeNotifier {
  // ---------------- User info ----------------
  String name = 'Sita Rai';
  String verifiedIdLabel = 'Verified Citizen ID (Nagarikta)';
  String email = 'sita.rai@gmail.com';
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
  String lastLogin = 'Today, 08:14 AM';
  String terminalRegionStatus = 'SUCCESS';
  String terminalRegion = 'Biratnagar';
  String sessionDevice = 'Samsung Galaxy S23 (Android 14)';
  String firebaseAuthUid = '#usr_nep_99214';

  // ---------------- App & travel preferences ----------------
  bool pushNotifications = true;
  bool isEnglish = true; // false => नेपाली
  bool highContrastMode = true;
  bool audioAnnouncements = true;

  // ---------------- Help & official transit desk ----------------
  String helplineLabel = 'Transit Helpline';
  String helplineNumber = 'Toll-Free 103 / 021-524100';
  String privacyPolicyLabel = 'Privacy Policy & Terms of Carriage';

  // ---------------- App info ----------------
  String appFooter = 'NVTS Nepal Transit  •  App Version 3.4.1 (Build 412)';

  // ---------------- Actions ----------------
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

  Future<void> logout() async {
    // TODO: hook up real Firebase sign-out here.
    debugPrint('Logging out from Firebase...');
  }
}