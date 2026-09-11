import 'package:flutter/material.dart';

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
  /// (e.g. "Delay > 30m" under Critical).
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

  /// Small status line shown under the stage label.
  String get subLabel {
    switch (this) {
      case IncidentStage.submitted:
        return '09:35';
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

  const PhotoAttachment({required this.id, required this.label});
}

class ReportIssueProvider extends ChangeNotifier {
  // ---------------- Top banner / navigation ----------------
  final String corridorLabel = 'KOSHI CORRIDOR DISPATCH LINK';
  final String backLinkLabel = 'Return to Route';
  final String pageTitle = 'Report Operational Issue';
  final String pageSubtitle =
      'Send live vehicle diagnostics, geo-stamp, and incident details '
      'directly to Biratnagar Central Fleet Ops.';

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
    'Engine coolant temperature gauge spiked to 105°C near Tankisinuwari '
        'chowk. Pulled over safely to check fan belt. Requesting backup '
        'mechanic team.',
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

  /// Hook this up to your speech-to-text service.
  void startVoiceRecording() {
    // TODO: integrate voice-to-text capture.
    notifyListeners();
  }

  // ---------------- Photo attachments ----------------
  final List<PhotoAttachment> photos = [
    const PhotoAttachment(id: '1', label: 'TEMP_HUD'),
  ];

  void takePhoto() {
    // TODO: integrate camera capture.
    photos.add(
      PhotoAttachment(id: DateTime.now().millisecondsSinceEpoch.toString(), label: 'PHOTO'),
    );
    notifyListeners();
  }

  void browseFiles() {
    // TODO: integrate file picker.
    notifyListeners();
  }

  void removePhoto(String id) {
    photos.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  // ---------------- Submit ----------------
  final String warningBannerText =
      'High severity triggers automated SMS alerts to Koshi Regional '
      'Workshop and pauses passenger ticketing for subsequent stops on '
      'Biratnagar Highway.';
  final String radioDispatchContact = '+977-21-460290';

  bool isSubmitting = false;

  Future<void> submitIssueToDispatch() async {
    isSubmitting = true;
    notifyListeners();
    // TODO: call your dispatch API here.
    await Future.delayed(const Duration(milliseconds: 600));
    isSubmitting = false;
    notifyListeners();
  }

  // ---------------- Incident tracking card ----------------
  final String reportId = '#REP-8942';
  final String loggedAgo = 'Logged 6m ago';
  final String severityBadge = 'High Severity';
  final String issueTitle = 'Engine Coolant Warning';
  final IncidentStage currentStage = IncidentStage.underReview;

  final String opsAuthor = 'Ops Dispatch Desk (Biratnagar Central)';
  final String opsMessage =
      '"Operator Sunil Shrestha reviewing telemetry data. Keep vehicle '
      'parked in shade off the main highway lane. Mobile team en route '
      'from Duhabi depot."';
  final String dispatchContactName = 'Sunil Shrestha';

  void callDispatchContact() {
    // TODO: integrate url_launcher tel: call.
    notifyListeners();
  }

  void triggerSOS() {
    // TODO: integrate with dispatch hotline / emergency service.
    notifyListeners();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}