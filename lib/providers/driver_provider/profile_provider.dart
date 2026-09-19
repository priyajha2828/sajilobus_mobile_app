import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/driver_service.dart';

class DriverProfileModel {
  final int? id;
  final String name;
  final String role;
  final String division;
  final String photoUrl;
  bool isOnlineActive;
  final double rating;
  final int totalTrips;
  final int completedTrips;
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
    this.id,
    required this.name,
    required this.role,
    required this.division,
    required this.photoUrl,
    required this.isOnlineActive,
    required this.rating,
    required this.totalTrips,
    required this.completedTrips,
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

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
    final driver = json['driver'] ?? json;
    final stats = driver['stats'] ?? {};
    final assignment = driver['assignment'] ?? {};
    final bus = assignment['bus'] ?? driver['activeTrip']?['bus'] ?? {};
    final activeTrip = driver['activeTrip'];
    final route = activeTrip?['route'];

    return DriverProfileModel(
      id: driver['id'],
      name: driver['name'] ?? 'Driver Name',
      role: 'Senior Fleet Driver',
      division: 'Koshi Division',
      photoUrl: driver['photoUrl'] ?? 'https://i.pravatar.cc/300?img=12',
      isOnlineActive: driver['isAvailable'] ?? true,
      rating: (driver['rating'] != null) ? (driver['rating'] as num).toDouble() : 4.8,
      totalTrips: stats['totalTrips'] ?? 0,
      completedTrips: stats['completedTrips'] ?? 0,
      safetyScorePercent: 99.2,
      tenure: '5y 4m',
      driverBadgeId: 'DRV-${driver['id'] != null ? driver['id'].toString().padLeft(3, '0') : '001'}',
      assignedBusLabel: bus['busNumber'] != null
          ? "${bus['busNumber']} (${bus['model'] ?? 'Standard'})"
          : 'BUS-101 (Deluxe Coach)',
      plateNepali: bus['plateNumber'] ?? 'बा २ ख ४५६७',
      plateEnglish: bus['plateNumber'] ?? 'BA 2 KHA 4567',
      commercialLicense: driver['licenseNo'] ?? 'KOSHI-2025-45879',
      licenseValidTill: 'Valid till: 2030',
      registeredPhone: driver['phone'] ?? '+977 9801234567',
      otpVerified: true,
      fleetEmail: driver['email'] ?? 'driver@fleettrack.np',
      firebaseAuthVerified: true,
      routeFrom: route?['startPoint'] ?? 'Biratnagar Bus Park',
      routeTo: route?['endPoint'] ?? 'Itahari Terminal',
      inCabAudioAlerts: true,
      speedLimitWarningBeep: true,
      nightDrivingMode: 'Auto (Sunset)',
      interfaceLanguage: 'नेपाली / ENG',
      offlineMapRegion: 'Koshi Province',
      offlineMapSizeCached: '142 MB Cached',
    );
  }

  factory DriverProfileModel.mock() {
    return DriverProfileModel(
      name: 'Ram Kumar Yadav',
      role: 'Senior Fleet Driver',
      division: 'Koshi Division',
      photoUrl: 'https://i.pravatar.cc/300?img=12',
      isOnlineActive: true,
      rating: 4.8,
      totalTrips: 1248,
      completedTrips: 1200,
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

  final DriverService _driverService = DriverService();
  final ImagePicker _picker = ImagePicker();

  File? _localPhotoFile;
  bool _isUploadingPhoto = false;

  DriverProfileModel get profile => _profile;
  bool get isLoading => _isLoading;
  bool get isLoggingOut => _isLoggingOut;
  File? get localPhotoFile => _localPhotoFile;
  bool get isUploadingPhoto => _isUploadingPhoto;

  DriverProfileProvider() {
    loadProfile();
  }

  Future<void> loadProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");

      if (token != null && token.isNotEmpty) {
        final response = await _driverService.getProfile(token);
        if (response.statusCode == 200 && response.data["success"] == true) {
          _profile = DriverProfileModel.fromJson(response.data);
        }
      }
    } on DioException catch (e) {
      debugPrint("Driver profile load error: ${e.response?.data}");
    } catch (e) {
      debugPrint("Driver profile error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pickAndUpdatePhoto({required bool fromCamera}) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
      );
      if (picked == null) return;

      _localPhotoFile = File(picked.path);
      notifyListeners();

      _isUploadingPhoto = true;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");
      if (token != null) {
        // TODO: aafno DriverService ma upload endpoint banaera yaha call garne
        // final response = await _driverService.uploadProfilePhoto(token, _localPhotoFile!);
        // if (response.statusCode == 200) {
        //   _profile = _profile.copyWithPhoto(response.data['photoUrl']);
        // }
      }
    } catch (e) {
      debugPrint("Error picking/updating photo: $e");
    } finally {
      _isUploadingPhoto = false;
      notifyListeners();
    }
  }

  Future<void> toggleAvailability(bool value) async {
    _profile.isOnlineActive = value;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");
      if (token != null) {
        await _driverService.toggleAvailability(token, value);
      }
    } catch (e) {
      debugPrint("Error toggling availability: $e");
    }
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
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    _isLoggingOut = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("jwt_token");
      await prefs.remove("user_role");
    } catch (e) {
      debugPrint("Logout error: $e");
    } finally {
      _isLoggingOut = false;
      notifyListeners();

      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil('/loginpage', (route) => false);
      }
    }
  }

  Future<void> triggerSOS() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");
      if (token != null) {
        await _driverService.triggerSOS(token, {
          "latitude": 26.4837,
          "longitude": 87.2834,
          "message": "Emergency SOS alert from Driver Mobile App",
        });
      }
    } catch (e) {
      debugPrint("Error triggering SOS: $e");
    }
  }
}