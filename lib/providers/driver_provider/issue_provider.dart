import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/driver_service.dart';

/// One tappable tile in the "Select Issue Category" grid.
class IssueCategoryItem {
  final IconData icon;
  final String label;

  const IssueCategoryItem({required this.icon, required this.label});
}

/// One segment in the "Severity Level" selector.
class SeverityLevelItem {
  final String label;

  /// Extra line shown only when this severity is selected
  final String? subtitle;

  const SeverityLevelItem({required this.label, this.subtitle});
}

/// Stages of the incident-tracking stepper at the bottom of the screen.
enum IncidentStage { submitted, underReview, dispatched, resolved }

extension IncidentStageX on IncidentStage {
  String get label {
    switch (this) {
      case IncidentStage.submitted:
        return 'Submitted';
      case IncidentStage.underReview:
        return 'Under Review';
      case IncidentStage.dispatched:
        return 'Dispatched';
      case IncidentStage.resolved:
        return 'Resolved';
    }
  }

  String get subLabel {
    switch (this) {
      case IncidentStage.submitted:
        return 'Just now';
      case IncidentStage.underReview:
        return 'In Progress';
      case IncidentStage.dispatched:
        return 'Pending';
      case IncidentStage.resolved:
        return 'Station OK';
    }
  }
}

/// A photographic attachment the driver has captured for the report.
class PhotoAttachment {
  final String id;
  final String label;
  final File? file;
  final String? base64Data;

  const PhotoAttachment({
    required this.id,
    required this.label,
    this.file,
    this.base64Data,
  });
}

class ReportIssueProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final DriverService _driverService = DriverService();

  // ---------------- Top banner / navigation ----------------
  final String corridorLabel = 'KOSHI CORRIDOR DISPATCH LINK';
  final String backLinkLabel = 'Return to Route';
  final String pageTitle = 'Report Operational Issue';
  final String pageSubtitle =
      'Send live vehicle diagnostics, geo-stamp, and incident details '
      'directly to Central Fleet Ops.';

  // ---------------- Auto-locked diagnostics ----------------
  final bool isGpsLocked = true;
  final String vehicleId = 'BA 2 KHA 4567';
  final String busNumber = 'BUS-101';
  final String routeFrom = 'Biratnagar';
  final String routeTo = 'Itahari Hub';
  final String routeLine = 'Line 14-A';
  final String incidentCoordinates =
      '26.4837° N, 87.2834° E (Near Tankisinuwari Chowk)';

  // ---------------- Issue category ----------------
  final List<IssueCategoryItem> categories = const [
    IssueCategoryItem(icon: Icons.directions_car_filled_outlined, label: 'Vehicle Problem'),
    IssueCategoryItem(icon: Icons.traffic_outlined, label: 'Traffic Jam'),
    IssueCategoryItem(icon: Icons.block_outlined, label: 'Road Block'),
    IssueCategoryItem(icon: Icons.report_problem_outlined, label: 'Accident'),
    IssueCategoryItem(icon: Icons.local_gas_station_outlined, label: 'Fuel Issue'),
    IssueCategoryItem(icon: Icons.build_circle_outlined, label: 'Mechanical Failure'),
    IssueCategoryItem(icon: Icons.ac_unit_outlined, label: 'AC / Electrical'),
    IssueCategoryItem(icon: Icons.more_horiz_outlined, label: 'Other Issue'),
  ];

  int selectedCategoryIndex = 5; // "Mechanical Failure" pre-selected

  void selectCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }

  // ---------------- Severity level ----------------
  final List<SeverityLevelItem> severities = const [
    SeverityLevelItem(label: 'Low'),
    SeverityLevelItem(label: 'Medium'),
    SeverityLevelItem(label: 'Critical', subtitle: 'Delay > 30m'),
  ];

  int selectedSeverityIndex = 2; // "Critical" pre-selected

  void selectSeverity(int index) {
    selectedSeverityIndex = index;
    notifyListeners();
  }

  // ---------------- Issue description ----------------
  final TextEditingController descriptionController = TextEditingController(
    text:
    'Engine coolant temperature gauge spiked near Tankisinuwari chowk. Pulled over safely. Requesting mechanic backup team.',
  );
  final int maxDescriptionChars = 300;
  bool isTelemetrySynced = true;

  int get descriptionLength => descriptionController.text.length;

  void updateDescription(String value) {
    descriptionController.value = descriptionController.value.copyWith(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
    notifyListeners();
  }

  void startVoiceRecording() {
    notifyListeners();
  }

  // ---------------- Photo attachments ----------------
  final List<PhotoAttachment> photos = [];

  Future<void> takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxWidth: 1024,
      );
      if (photo != null) {
        final bytes = await photo.readAsBytes();
        final base64Str = 'data:image/jpeg;base64,${base64Encode(bytes)}';
        photos.add(
          PhotoAttachment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            label: 'CAM_${photos.length + 1}',
            file: File(photo.path),
            base64Data: base64Str,
          ),
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error taking photo: $e');
    }
  }

  Future<void> browseFiles() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1024,
      );
      if (photo != null) {
        final bytes = await photo.readAsBytes();
        final base64Str = 'data:image/jpeg;base64,${base64Encode(bytes)}';
        photos.add(
          PhotoAttachment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            label: 'IMG_${photos.length + 1}',
            file: File(photo.path),
            base64Data: base64Str,
          ),
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking photo from gallery: $e');
    }
  }

  void removePhoto(String id) {
    photos.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  // ---------------- Submit ----------------
  final String warningBannerText =
      'High severity triggers automated SMS alerts to Regional Workshop '
      'and notifies passengers waiting at subsequent stops.';
  final String radioDispatchContact = '+977-21-460290';

  bool isSubmitting = false;
  String? successMessage;
  String? errorMessage;

  Future<bool> submitIssueToDispatch() async {
    isSubmitting = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    try {
      final category = categories[selectedCategoryIndex].label;
      final severity = severities[selectedSeverityIndex].label;
      final description = descriptionController.text;

      String? photoBase64;
      if (photos.isNotEmpty) {
        photoBase64 = photos.last.base64Data;
      }

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final response = await _driverService.reportIssue(token, {
        'category': category,
        'severity': severity,
        'description': description,
        if (photoBase64 != null) 'photo': photoBase64,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        successMessage = response.data['message'] ?? 'Issue submitted successfully!';
        isSubmitting = false;
        notifyListeners();
        return true;
      } else {
        errorMessage = response.data['message'] ?? 'Failed to submit issue.';
      }
    } catch (e) {
      errorMessage = 'Error submitting issue: $e';
    }

    isSubmitting = false;
    notifyListeners();
    return false;
  }

  // ---------------- Incident tracking card ----------------
  final String reportId = '#REP-8942';
  final String loggedAgo = 'Logged just now';
  final String severityBadge = 'High Severity';
  final String issueTitle = 'Operational Alert Logged';
  final IncidentStage currentStage = IncidentStage.submitted;

  final String opsAuthor = 'Ops Dispatch Desk (Biratnagar Central)';
  final String opsMessage =
      '"Dispatch operator reviewing report. Vehicles and waiting passengers notified."';
  final String dispatchContactName = 'Sunil Shrestha';

  void callDispatchContact() {
    notifyListeners();
  }

  void triggerSOS() {
    notifyListeners();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}