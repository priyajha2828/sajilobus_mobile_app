import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sajilo_bus/config/dio_client.dart';

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

class DriverSosHistoryItem {
  final int id;
  final String status;
  final String message;
  final String createdAt;

  const DriverSosHistoryItem({
    required this.id,
    required this.status,
    required this.message,
    required this.createdAt,
  });
}

class EmergencyProvider extends ChangeNotifier {
  EmergencyModel _model = EmergencyModel.mock();
  bool _isLoading = false;
  bool _isBroadcasting = false;
  bool _sosSent = false;
  Timer? _pollingTimer;
  List<DriverSosHistoryItem> _sosHistory = [];

  EmergencyModel get model => _model;
  bool get isLoading => _isLoading;
  bool get isBroadcasting => _isBroadcasting;
  bool get sosSent => _sosSent;
  List<DriverSosHistoryItem> get sosHistory => _sosHistory;

  EmergencyProvider() {
    fetchDriverSosStatus();
    _startStatusPolling();
  }

  void _startStatusPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      fetchDriverSosStatus();
    });
  }

  Future<void> fetchDriverSosStatus() async {
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
            final String msg = a["message"] ?? "Emergency Alert";
            final String created = a["createdAt"] != null
                ? DateTime.tryParse(a["createdAt"].toString())?.toLocal().toString().split('.').first ?? ""
                : "";
            return DriverSosHistoryItem(id: id, status: st, message: msg, createdAt: created);
          }).toList();

          final firstAlert = alerts.first;
          final String status = firstAlert["status"] ?? "PENDING";
          final int alertId = firstAlert["id"] ?? 9114;

          String queueLabel = "Queue: Top #1 ($status)";
          if (status == "RESOLVED") queueLabel = "RESOLVED by Admin";
          else if (status == "IN_PROGRESS") queueLabel = "IN PROGRESS • Admin Dispatched";

          _model = EmergencyModel(
            selectedType: _model.selectedType,
            typeOptions: _model.typeOptions,
            telemetry: _model.telemetry,
            quickLogText: _model.quickLogText,
            quickLogTags: _model.quickLogTags,
            isAudioLogging: _model.isAudioLogging,
            priorityTicket: PriorityTicket(
              ticketId: "KS-$alertId",
              timeAgo: _model.priorityTicket.timeAgo,
              targetLabel: _model.priorityTicket.targetLabel,
              gpsSync: true,
              passengersTagged: true,
              passengerCount: _model.priorityTicket.passengerCount,
              towAlertSent: true,
              queueLabel: queueLabel,
            ),
            voiceChannels: _model.voiceChannels,
          );
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Driver SOS status fetch error: $e");
    }
  }

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

    final typeLabel = _model.selectedType.name.toUpperCase();
    final logText = _model.quickLogText;
    final fullMsg = "🚨 DRIVER EMERGENCY SOS [$typeLabel]: $logText. Bus: ${_model.telemetry.plateNepali}. Coords: ${_model.telemetry.coordinates}";

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");

      if (token != null && token.isNotEmpty) {
        await DioClient.dio.post(
          "/sos",
          data: {
            "latitude": 26.4837,
            "longitude": 87.2834,
            "message": fullMsg,
          },
          options: Options(headers: {"Authorization": "Bearer $token"}),
        );
      }
    } catch (e) {
      debugPrint("Driver SOS broadcast error: $e");
    }

    try {
      final Uri smsUri = Uri(
        scheme: 'sms',
        path: '100',
        queryParameters: <String, String>{
          'body': fullMsg,
        },
      );
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        await launchUrl(smsUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint("Driver SMS launch error: $e");
    } finally {
      _isBroadcasting = false;
      _sosSent = true;
      notifyListeners();
    }
  }

  Future<void> callChannel(String number) async {
    try {
      final cleanNumber = number.replaceAll(RegExp(r'[^\d+]'), '');
      final Uri phoneUri = Uri(scheme: 'tel', path: cleanNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint("Call channel launch error: $e");
    }
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }
}