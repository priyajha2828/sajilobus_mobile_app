import 'dart:async';
import 'package:flutter/material.dart';
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
  final DispatchStage currentStage = DispatchStage.pending;

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

  void _activateSos() {
    isHolding = false;
    sosActivated = true;
    // TODO: call your dispatch API to broadcast the live SOS alert here.
    notifyListeners();
  }

  void resetSos() {
    sosActivated = false;
    holdProgress = 0.0;
    notifyListeners();
  }

  // ---------------- Emergency call buttons ----------------
  final String policeHotline = '100';
  final String trafficPoliceLine = '103';

  void callNumber(String number) {
    // TODO: integrate url_launcher tel: call.
    notifyListeners();
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
    _holdTimer?.cancel();
    descriptionController.dispose();
    super.dispose();
  }
}