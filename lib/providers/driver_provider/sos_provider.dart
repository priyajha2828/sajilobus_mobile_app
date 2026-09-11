import 'package:flutter/material.dart';

enum EmergencyType { vehicleFail, collision, medical, security }

class EmergencyTypeOption {
  final EmergencyType type;
  final String title;
  final String subtitle;
  final String icon; // maps to IconData in the widget

  const EmergencyTypeOption({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class TelemetrySnapshot {
  final String plateNepali;
  final String fleetDesignation;
  final String coordinates;
  final String waypointLabel;
  final int passengerCount;
  final String capacityStatus;
  final String routeFrom;
  final String routeTo;
  final String transitLine;
  final String dutyCaptainName;
  final String dutyCaptainPhone;
  final String mapLocationLabel;

  const TelemetrySnapshot({
    required this.plateNepali,
    required this.fleetDesignation,
    required this.coordinates,
    required this.waypointLabel,
    required this.passengerCount,
    required this.capacityStatus,
    required this.routeFrom,
    required this.routeTo,
    required this.transitLine,
    required this.dutyCaptainName,
    required this.dutyCaptainPhone,
    required this.mapLocationLabel,
  });
}

class PriorityTicket {
  final String ticketId;
  final String timeAgo;
  final String targetLabel;
  final bool gpsSync;
  final bool passengersTagged;
  final int passengerCount;
  final bool towAlertSent;
  final String queueLabel;

  const PriorityTicket({
    required this.ticketId,
    required this.timeAgo,
    required this.targetLabel,
    required this.gpsSync,
    required this.passengersTagged,
    required this.passengerCount,
    required this.towAlertSent,
    required this.queueLabel,
  });
}

class VoiceChannel {
  final String label;
  final String number;
  final String icon;

  const VoiceChannel({
    required this.label,
    required this.number,
    required this.icon,
  });
}

class EmergencyModel {
  EmergencyType selectedType;
  final List<EmergencyTypeOption> typeOptions;
  final TelemetrySnapshot telemetry;
  String quickLogText;
  final List<String> quickLogTags;
  bool isAudioLogging;
  final PriorityTicket priorityTicket;
  final List<VoiceChannel> voiceChannels;

  EmergencyModel({
    required this.selectedType,
    required this.typeOptions,
    required this.telemetry,
    required this.quickLogText,
    required this.quickLogTags,
    required this.isAudioLogging,
    required this.priorityTicket,
    required this.voiceChannels,
  });

  factory EmergencyModel.mock() {
    return EmergencyModel(
      selectedType: EmergencyType.collision,
      typeOptions: const [
        EmergencyTypeOption(
          type: EmergencyType.vehicleFail,
          title: 'Vehicle Fail',
          subtitle: 'Engine / Mechanical',
          icon: 'directions_bus',
        ),
        EmergencyTypeOption(
          type: EmergencyType.collision,
          title: 'Collision',
          subtitle: 'Road Incident',
          icon: 'car_crash',
        ),
        EmergencyTypeOption(
          type: EmergencyType.medical,
          title: 'Medical',
          subtitle: 'Injury / Medic',
          icon: 'medical_services',
        ),
        EmergencyTypeOption(
          type: EmergencyType.security,
          title: 'Security Threat',
          subtitle: 'Hostile / Unrest',
          icon: 'shield',
        ),
      ],
      telemetry: const TelemetrySnapshot(
        plateNepali: 'बा २ ख ४५६७',
        fleetDesignation: 'BUS-101 (Deluxe)',
        coordinates: '26.4837° N, 87.2834° E',
        waypointLabel: 'Koshi Highway, KM 14',
        passengerCount: 32,
        capacityStatus: 'Capacity 82% OK',
        routeFrom: 'Biratnagar',
        routeTo: 'Itahari',
        transitLine: 'Transit Line #4A',
        dutyCaptainName: 'Ram Kumar Yadav',
        dutyCaptainPhone: '+977 9801234567',
        mapLocationLabel: 'Koshi Corridor • Near Duhabi Bridge',
      ),
      quickLogText:
      '"All passengers safe, minor front bumper impact, lane partially blocked on south shoulder."',
      quickLogTags: const [
        'Ambulance Not Required',
        'Traffic Halting',
        'Engine Fluid Leak',
      ],
      isAudioLogging: false,
      priorityTicket: const PriorityTicket(
        ticketId: 'KS-9114',
        timeAgo: '00:00:03 Ago',
        targetLabel:
        'BA 2 KHA 4567 • Auto-bridging Koshi Traffic Police (103) & Regional Duty Room.',
        gpsSync: true,
        passengersTagged: true,
        passengerCount: 32,
        towAlertSent: true,
        queueLabel: 'Queue: Top #1',
      ),
      voiceChannels: const [
        VoiceChannel(label: 'Fleet HQ', number: '021-523456', icon: 'headset'),
        VoiceChannel(label: 'Police', number: 'Dial 100', icon: 'shield'),
        VoiceChannel(label: 'Ambulance', number: 'Dial 102', icon: 'medical'),
      ],
    );
  }
}

class EmergencyProvider extends ChangeNotifier {
  EmergencyModel _model = EmergencyModel.mock();
  bool _isLoading = false;
  bool _isBroadcasting = false;
  bool _sosSent = false;

  EmergencyModel get model => _model;
  bool get isLoading => _isLoading;
  bool get isBroadcasting => _isBroadcasting;
  bool get sosSent => _sosSent;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));
    _model = EmergencyModel.mock();

    _isLoading = false;
    notifyListeners();
  }

  void selectEmergencyType(EmergencyType type) {
    _model.selectedType = type;
    notifyListeners();
  }

  void updateQuickLog(String text) {
    _model.quickLogText = text;
    notifyListeners();
  }

  void toggleAudioLogging() {
    _model.isAudioLogging = !_model.isAudioLogging;
    notifyListeners();
    // integrate with speech-to-text / audio recorder here
  }

  Future<void> broadcastSOS() async {
    _isBroadcasting = true;
    notifyListeners();

    // Simulate hold-to-confirm dispatch call
    await Future.delayed(const Duration(seconds: 2));

    _isBroadcasting = false;
    _sosSent = true;
    notifyListeners();

    // integrate with actual dispatch/telemetry broadcast API here
  }

  void callChannel(String number) {
    // integrate url_launcher: launch('tel:$number')
  }
}