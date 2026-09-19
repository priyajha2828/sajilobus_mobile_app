import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sajilo_bus/config/dio_client.dart';
/// Stages of the live dispatch lifecycle stepper.
enum DispatchStage { pending, inProgress, resolved }

extension DispatchStageX on DispatchStage {
  String get label {
    switch (this) {
      case DispatchStage.pending:
        return 'PENDING';
      case DispatchStage.inProgress:
        return 'IN_PROGRESS';
      case DispatchStage.resolved:
        return 'RESOLVED';
    }
  }

  String get subLabel {
    switch (this) {
      case DispatchStage.pending:
        return 'Armed';
      case DispatchStage.inProgress:
        return 'Fleet Notified';
      case DispatchStage.resolved:
        return 'Safe & Closed';
    }
  }

  IconData get icon {
    switch (this) {
      case DispatchStage.pending:
        return Icons.radio_button_checked;
      case DispatchStage.inProgress:
        return Icons.podcasts;
      case DispatchStage.resolved:
        return Icons.check;
    }
  }
}

/// One selectable tile in the "Nature of Emergency" grid.
class EmergencyType {
  final IconData icon;
  final String label;
  final String subtitle;

  const EmergencyType({
    required this.icon,
    required this.label,
    required this.subtitle,
  });
}

/// One row inside the Central Transit Dispatch Preview card.
class DispatchInfoRow {
  final String label;
  final String value;
  final bool isLink;
  final IconData? leadingIcon;

  const DispatchInfoRow({
    required this.label,
    required this.value,
    this.isLink = false,
    this.leadingIcon,
  });
}
class SosHistoryItem {
  final int id;
  final String status;
  final String message;
  final String createdAt;

  const SosHistoryItem({
    required this.id,
    required this.status,
    required this.message,
    required this.createdAt,
  });
}

class PassengerSosProvider extends ChangeNotifier {
  // ---------------- Top emergency banner ----------------
  final String bannerTitle = 'Emergency Transit SOS';
  final String bannerSubtitle =
      'Direct priority link to Nepal Police (100) & Central Dispatch';
  final bool isLiveLine = true;

  // ---------------- Telemetry / GPS ----------------
  final String accuracyLabel = '±3m Accuracy';
  final String gpsCoordinates = '26.4525° N, 87.2718° E';
  final String gpsSubtext = 'Near Tankisinuwari Chowk, Koshi Rajmarg';

  // ---------------- Vehicle search_route row ----------------
  final String vehiclePlate = 'BA 2 KHA 8492';
  final String vehicleBadge = 'Koshi Express';
  final String routeLabel = 'Route 104: Biratnagar → Itahari';
  final String speedLabel = 'Speed: 38 km/h';

  // ---------------- Dispatch lifecycle ----------------
  DispatchStage _currentStage = DispatchStage.pending;
  DispatchStage get currentStage => _currentStage;
  int? _lastActiveSosId;
  Timer? _pollingTimer;
  List<SosHistoryItem> _sosHistory = [];
  List<SosHistoryItem> get sosHistory => _sosHistory;

  PassengerSosProvider() {
    fetchLatestSosStatus();
    _startStatusPolling();
  }

  void _startStatusPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      fetchLatestSosStatus();
    });
  }

  Future<void> fetchLatestSosStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");
      final options = (token != null && token.isNotEmpty)
          ? Options(headers: {"Authorization": "Bearer $token"})
          : null;

      final res = await DioClient.dio.get(
        "/sos",
        options: options,
      );

      if (res.statusCode == 200 && res.data["success"] == true) {
        final List? alerts = res.data["sosAlerts"];
        if (alerts != null && alerts.isNotEmpty) {
          _sosHistory = alerts.map((a) {
            final int id = a["id"] ?? 0;
            final String st = a["status"] ?? "PENDING";
            final String msg = a["message"] ?? "Emergency SOS";
            final String created = a["createdAt"] != null
                ? DateTime.tryParse(a["createdAt"].toString())?.toLocal().toString().split('.').first ?? ""
                : "";
            return SosHistoryItem(id: id, status: st, message: msg, createdAt: created);
          }).toList();

          // If we tracked an activated SOS, look up that ID, else take the most recent one
          Map? targetAlert;
          if (_lastActiveSosId != null) {
            targetAlert = alerts.firstWhere(
              (a) => a["id"]?.toString() == _lastActiveSosId?.toString(),
              orElse: () => alerts.first,
            );
          } else {
            targetAlert = alerts.first;
          }

          if (targetAlert != null) {
            final String status = (targetAlert["status"] ?? "PENDING").toString().toUpperCase();
            if (status == "RESOLVED") {
              _currentStage = DispatchStage.resolved;
              sosActivated = true;
            } else if (status == "IN_PROGRESS") {
              _currentStage = DispatchStage.inProgress;
              sosActivated = true;
            } else {
              _currentStage = DispatchStage.pending;
            }
          }
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Passenger SOS status fetch error: $e");
    }
  }

  // ---------------- Nature of Emergency ----------------
  final List<EmergencyType> emergencyTypes = const [
    EmergencyType(
      icon: Icons.medical_services_outlined,
      label: 'Medical Issue',
      subtitle: 'Injury or illness',
    ),
    EmergencyType(
      icon: Icons.shield_outlined,
      label: 'Harassment',
      subtitle: 'Safety concern',
    ),
    EmergencyType(
      icon: Icons.car_crash_outlined,
      label: 'Collision',
      subtitle: 'Road accident',
    ),
    EmergencyType(
      icon: Icons.speed_outlined,
      label: 'Rash Driving',
      subtitle: 'Reckless speed',
    ),
  ];

  int selectedEmergencyIndex = 1; // "Harassment" pre-selected

  void selectEmergencyType(int index) {
    selectedEmergencyIndex = index;
    notifyListeners();
  }

  // ---------------- Incident details ----------------
  final TextEditingController descriptionController = TextEditingController();

  void updateDescription(String value) {
    notifyListeners();
  }

  void startVoiceInput() {
    // TODO: integrate speech-to-text capture.
    notifyListeners();
  }

  // ---------------- Critical Response Initiator (hold-to-activate) ----------------
  final Duration holdDuration = const Duration(milliseconds: 2000);
  double holdProgress = 0.0; // 0.0 - 1.0
  bool isHolding = false;
  bool sosActivated = false;
  Timer? _holdTimer;

  final String policeContactLabel = 'Police Transit Control (100)';
  final int emergencyContactCount = 2;

  void startHold() {
    if (sosActivated) return;
    isHolding = true;
    holdProgress = 0.0;
    const tickMs = 50;
    _holdTimer?.cancel();
    _holdTimer = Timer.periodic(const Duration(milliseconds: tickMs), (timer) {
      holdProgress += tickMs / holdDuration.inMilliseconds;
      if (holdProgress >= 1.0) {
        holdProgress = 1.0;
        timer.cancel();
        _activateSos();
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void cancelHold() {
    if (sosActivated) return;
    _holdTimer?.cancel();
    isHolding = false;
    holdProgress = 0.0;
    notifyListeners();
  }

  Future<void> _activateSos() async {
    isHolding = false;
    sosActivated = true;
    notifyListeners();

    final selectedTypeLabel = emergencyTypes[selectedEmergencyIndex].label;
    final customMsg = descriptionController.text.trim();
    final messageText = customMsg.isNotEmpty
        ? "🚨 EMERGENCY SOS ALERT! [$selectedTypeLabel] $customMsg. Location: Lat 26.4525, Lng 87.2718"
        : "🚨 EMERGENCY SOS ALERT! [$selectedTypeLabel] I need immediate help! Location: Lat 26.4525, Lng 87.2718";

    String targetPhoneNumber = '100'; // Fallback emergency number

    // 1. Post to Backend (saves to DB and notifies Admin)
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");

      if (token != null && token.isNotEmpty) {
        final res = await DioClient.dio.post(
          "/sos",
          data: {
            "latitude": 26.4525,
            "longitude": 87.2718,
            "message": messageText,
          },
          options: Options(headers: {"Authorization": "Bearer $token"}),
        );

        if (res.statusCode == 200 || res.statusCode == 201) {
          final sosData = res.data["sos"];
          if (sosData != null && sosData["id"] != null) {
            _lastActiveSosId = sosData["id"];
          }
          if (sosData != null && sosData["emergencyContacts"] != null) {
            final List contactsList = sosData["emergencyContacts"];
            if (contactsList.isNotEmpty) {
              final firstContact = contactsList.first;
              if (firstContact["contactNumber"] != null &&
                  firstContact["contactNumber"].toString().isNotEmpty) {
                targetPhoneNumber = firstContact["contactNumber"].toString();
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint("Passenger SOS backend trigger error: $e");
    }

    // If targetPhoneNumber was not found from POST /sos, fetch from /sos-contacts
    if (targetPhoneNumber == '100') {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("jwt_token");
        if (token != null && token.isNotEmpty) {
          final contactRes = await DioClient.dio.get(
            "/sos-contacts",
            options: Options(headers: {"Authorization": "Bearer $token"}),
          );
          if (contactRes.statusCode == 200 && contactRes.data["success"] == true) {
            final List? contacts = contactRes.data["contacts"];
            if (contacts != null && contacts.isNotEmpty) {
              final firstNumber = contacts.first["contactNumber"];
              if (firstNumber != null && firstNumber.toString().isNotEmpty) {
                targetPhoneNumber = firstNumber.toString();
              }
            }
          }
        }
      } catch (e) {
        debugPrint("Error fetching emergency contacts for SMS: $e");
      }
    }

    // 2. Open Native SMS Messaging App prefilled with custom message to emergency SOS contact
    try {
      final cleanPhone = targetPhoneNumber.replaceAll(' ', '');
      final Uri smsUri = Uri(
        scheme: 'sms',
        path: cleanPhone,
        queryParameters: <String, String>{
          'body': messageText,
        },
      );
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        await launchUrl(smsUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint("Native SMS launch error: $e");
    }
  }

  void resetSos() {
    sosActivated = false;
    holdProgress = 0.0;
    notifyListeners();
  }

  // ---------------- Emergency call buttons ----------------
  final String policeHotline = '100';
  final String trafficPoliceLine = '103';

  Future<void> callNumber(String number) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: number);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint("Call launch error: $e");
    }
  }

  // ---------------- Central Transit Dispatch Preview ----------------
  final String dispatchUnit = 'Itahari Transit Control Desk';
  final String dispatchProtocol = 'Priority Intercept #NEP-9021';
  final String familyAlertLabel = '2 Contacts Armed (SMS + Live Pin)';
  final String channelLabel = 'Encrypted Gov Transit Channel';

  void openDispatchSettings() {
    // TODO: navigate to dispatch/emergency-contact settings.
    notifyListeners();
  }

  // ---------------- Footer ----------------
  void returnToNavigation() {
    // TODO: pop back to the live navigation/tracking screen.
    notifyListeners();
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _holdTimer?.cancel();
    descriptionController.dispose();
    super.dispose();
  }
}