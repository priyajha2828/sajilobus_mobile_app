import 'dart:async';
import 'package:flutter/material.dart';

/// The three stages of the live dispatch lifecycle stepper.
enum DispatchStage { pending, inProgress, resolved }

/// Model for a selectable "Nature of Emergency" tile.
class EmergencyType {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;

  const EmergencyType({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
  });
}

/// Simple model describing the currently tracked vehicle.
class VehicleInfo {
  final String plate;
  final String routeLabel;
  final String routeDetail;
  final String speedKmh;

  const VehicleInfo({
    required this.plate,
    required this.routeLabel,
    required this.routeDetail,
    required this.speedKmh,
  });
}

/// Simple model describing the live GPS fix.
class GpsFix {
  final String coordinates;
  final String nearestLandmark;
  final String accuracyLabel;

  const GpsFix({
    required this.coordinates,
    required this.nearestLandmark,
    required this.accuracyLabel,
  });
}

class EmergencyProvider extends ChangeNotifier {
  EmergencyProvider();

  // ---------------------------------------------------------------------
  // Static / demo data - in a real app this would come from a repository.
  // ---------------------------------------------------------------------
  final VehicleInfo vehicle = const VehicleInfo(
    plate: 'BA 2 KHA ...',
    routeLabel: 'Koshi Express',
    routeDetail: 'Route 104: Biratnagar → Itahari',
    speedKmh: '38',
  );

  final GpsFix gpsFix = const GpsFix(
    coordinates: '26.4525° N, 87.2718° E',
    nearestLandmark: 'Near Tankisinuwari Chowk, Koshi Rajmarg',
    accuracyLabel: '±3m Accuracy',
  );

  final List<EmergencyType> emergencyTypes = const [
    EmergencyType(
      id: 'medical',
      title: 'Medical Issue',
      subtitle: 'Injury or illness',
      icon: Icons.medical_services_outlined,
      accent: Color(0xFF2563EB),
    ),
    EmergencyType(
      id: 'harassment',
      title: 'Harassment',
      subtitle: 'Safety concern',
      icon: Icons.shield_outlined,
      accent: Color(0xFFDC2626),
    ),
    EmergencyType(
      id: 'collision',
      title: 'Collision',
      subtitle: 'Road accident',
      icon: Icons.car_crash_outlined,
      accent: Color(0xFFF59E0B),
    ),
    EmergencyType(
      id: 'rash_driving',
      title: 'Rash Driving',
      subtitle: 'Reckless speed',
      icon: Icons.speed_outlined,
      accent: Color(0xFF7C3AED),
    ),
  ];

  // ---------------------------------------------------------------------
  // Dispatch lifecycle
  // ---------------------------------------------------------------------
  DispatchStage dispatchStage = DispatchStage.pending;

  // ---------------------------------------------------------------------
  // Nature of emergency selection (multi-select, per "Select one or more")
  // ---------------------------------------------------------------------
  final Set<String> _selectedEmergencyIds = {};

  bool isSelected(String id) => _selectedEmergencyIds.contains(id);

  void toggleEmergencyType(String id) {
    if (_selectedEmergencyIds.contains(id)) {
      _selectedEmergencyIds.remove(id);
    } else {
      _selectedEmergencyIds.add(id);
    }
    notifyListeners();
  }

  // ---------------------------------------------------------------------
  // Incident details text field
  // ---------------------------------------------------------------------
  final TextEditingController incidentDetailsController = TextEditingController();

  // ---------------------------------------------------------------------
  // SOS hold-to-activate logic (Hold 2s)
  // ---------------------------------------------------------------------
  static const Duration holdDuration = Duration(milliseconds: 2000);

  double sosProgress = 0.0; // 0.0 -> 1.0
  bool isSosActivated = false;
  Timer? _sosTimer;

  void startSosHold() {
    if (isSosActivated) return;
    _sosTimer?.cancel();
    sosProgress = 0.0;
    const tickMs = 30;
    final totalTicks = holdDuration.inMilliseconds ~/ tickMs;
    var currentTick = 0;

    _sosTimer = Timer.periodic(const Duration(milliseconds: tickMs), (timer) {
      currentTick++;
      sosProgress = (currentTick / totalTicks).clamp(0.0, 1.0);
      if (sosProgress >= 1.0) {
        isSosActivated = true;
        timer.cancel();
      }
      notifyListeners();
    });
  }

  void cancelSosHold() {
    if (isSosActivated) return; // already fired, do not cancel
    _sosTimer?.cancel();
    sosProgress = 0.0;
    notifyListeners();
  }

  void resetSos() {
    _sosTimer?.cancel();
    sosProgress = 0.0;
    isSosActivated = false;
    dispatchStage = DispatchStage.pending;
    notifyListeners();
  }

  @override
  void dispose() {
    _sosTimer?.cancel();
    incidentDetailsController.dispose();
    super.dispose();
  }
}