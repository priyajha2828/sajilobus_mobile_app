import 'package:flutter/material.dart';

class DriverProfileModel {
  final String name;
  final String role;
  final String division;
  final String photoUrl;
  final bool isOnlineActive;
  final double rating;
  final int totalTrips;
  final double safetyScorePercent;
  final String tenure;

  final String driverBadgeId;
  final String assignedBusLabel;
  final String plateNepali;
  final String plateEnglish;

  final String commercialLicense;
  final String licenseValidTill;

  final String registeredPhone;
  final bool otpVerified;

  final String fleetEmail;
  final bool firebaseAuthVerified;

  final String routeFrom;
  final String routeTo;

  bool inCabAudioAlerts;
  bool speedLimitWarningBeep;
  String nightDrivingMode;
  String interfaceLanguage;
  String offlineMapRegion;
  String offlineMapSizeCached;

  DriverProfileModel({
    required this.name,
    required this.role,
    required this.division,
    required this.photoUrl,
    required this.isOnlineActive,
    required this.rating,
    required this.totalTrips,
    required this.safetyScorePercent,
    required this.tenure,
    required this.driverBadgeId,
    required this.assignedBusLabel,
    required this.plateNepali,
    required this.plateEnglish,
    required this.commercialLicense,
    required this.licenseValidTill,
    required this.registeredPhone,
    required this.otpVerified,
    required this.fleetEmail,
    required this.firebaseAuthVerified,
    required this.routeFrom,
    required this.routeTo,
    required this.inCabAudioAlerts,
    required this.speedLimitWarningBeep,
    required this.nightDrivingMode,
    required this.interfaceLanguage,
    required this.offlineMapRegion,
    required this.offlineMapSizeCached,
  });

  factory DriverProfileModel.mock() {
    return DriverProfileModel(
      name: 'Ram Kumar Yadav',
      role: 'Senior Fleet Driver',
      division: 'Koshi Division',
      photoUrl: 'https://i.pravatar.cc/300?img=12',
      isOnlineActive: true,
      rating: 4.8,
      totalTrips: 1248,
      safetyScorePercent: 99.2,
      tenure: '5y 4m',
      driverBadgeId: 'DRV-001',
      assignedBusLabel: 'BUS-101 (Deluxe 40-Seat)',
      plateNepali: 'बा २ ख ४५६७',
      plateEnglish: 'BA 2 KHA 4567',
      commercialLicense: 'KOSHI-2025-45879',
      licenseValidTill: 'Valid till: 2030',
      registeredPhone: '+977 9801234567',
      otpVerified: true,
      fleetEmail: 'ram.yadav@fleettrack.np',
      firebaseAuthVerified: true,
      routeFrom: 'Biratnagar Bus Park',
      routeTo: 'Itahari Terminal',
      inCabAudioAlerts: true,
      speedLimitWarningBeep: true,
      nightDrivingMode: 'Auto (Sunset)',
      interfaceLanguage: 'नेपाली / ENG',
      offlineMapRegion: 'Koshi Province',
      offlineMapSizeCached: '142 MB Cached',
    );
  }
}

class DriverProfileProvider extends ChangeNotifier {
  DriverProfileModel _profile = DriverProfileModel.mock();
  bool _isLoading = false;
  bool _isLoggingOut = false;

  DriverProfileModel get profile => _profile;
  bool get isLoading => _isLoading;
  bool get isLoggingOut => _isLoggingOut;

  Future<void> loadProfile() async {
    _isLoading = true;
    notifyListeners();

    // Replace with actual API / repository call
    await Future.delayed(const Duration(milliseconds: 400));
    _profile = DriverProfileModel.mock();

    _isLoading = false;
    notifyListeners();
  }

  void toggleInCabAudioAlerts(bool value) {
    _profile.inCabAudioAlerts = value;
    notifyListeners();
  }

  void toggleSpeedLimitBeep(bool value) {
    _profile.speedLimitWarningBeep = value;
    notifyListeners();
  }

  void refreshOfflineMapCache() {
    // trigger re-download / re-cache logic here
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    _isLoggingOut = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));
    // clear session / tokens / navigate to login here

    _isLoggingOut = false;
    notifyListeners();
  }

  void triggerSOS() {
    // dispatch emergency alert logic here
  }
}