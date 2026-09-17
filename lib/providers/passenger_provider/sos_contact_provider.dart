import 'package:flutter/material.dart';

/// Model representing a single trusted emergency contact.
class EmergencyContact {
  EmergencyContact({
    required this.id,
    required this.name,
    required this.relationship,
    required this.phone,
    this.isPrimary = false,
    this.alertMode = AlertMode.instantSmsCall,
  });

  final String id;
  String name;
  String relationship;
  String phone;
  bool isPrimary;
  AlertMode alertMode;

  /// Two-letter initials shown on the avatar, e.g. "Ramesh Rai" -> "RR".
  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}

/// The two dispatch behaviors shown in the mock: instant call/SMS vs
/// automated GPS-link dispatch only.
enum AlertMode { instantSmsCall, automatedGpsDispatch }

extension AlertModeLabel on AlertMode {
  String get label => switch (this) {
    AlertMode.instantSmsCall => 'Instant SMS & Call Alert',
    AlertMode.automatedGpsDispatch => 'Automated GPS Dispatch',
  };
}

/// Central state holder for the Trusted Safety Circle / Passenger SOS screen.
///
/// Wrap the app (or the route) with:
/// ```dart
/// ChangeNotifierProvider(create: (_) => PassengerSosProvider()),
/// ```
class PassengerSosContactProvider extends ChangeNotifier {
  PassengerSosContactProvider() {
    _contacts.addAll([
      EmergencyContact(
        id: 'c1',
        name: 'Ramesh Rai',
        relationship: 'Father',
        phone: '+977 9842012345',
        isPrimary: true,
        alertMode: AlertMode.instantSmsCall,
      ),
      EmergencyContact(
        id: 'c2',
        name: 'Anisha Shrestha',
        relationship: 'Sister',
        phone: '+977 9819876543',
        alertMode: AlertMode.automatedGpsDispatch,
      ),
    ]);
  }

  static const int maxTrustedContacts = 5;

  bool isSafetyCircleActive = true;

  final List<EmergencyContact> _contacts = [];
  List<EmergencyContact> get contacts => List.unmodifiable(_contacts);

  bool get canAddMoreContacts => _contacts.length < maxTrustedContacts;

  // ---- Add-contact form state ----
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final List<String> relationshipOptions = const [
    'Father',
    'Mother',
    'Spouse',
    'Sister',
    'Brother',
    'Friend',
    'Guardian',
    'Other',
  ];

  String? selectedRelationship;
  String? formError;

  void setRelationship(String? value) {
    selectedRelationship = value;
    notifyListeners();
  }

  /// Validates and adds a new trusted contact from the form fields.
  /// Returns true on success.
  bool addContactFromForm() {
    final name = nameController.text.trim();
    final phoneDigits = phoneController.text.trim();

    if (!canAddMoreContacts) {
      formError = 'You can only add up to $maxTrustedContacts trusted contacts.';
      notifyListeners();
      return false;
    }
    if (name.isEmpty) {
      formError = 'Please enter the contact\'s full name.';
      notifyListeners();
      return false;
    }
    if (phoneDigits.length != 10 || !RegExp(r'^\d{10}$').hasMatch(phoneDigits)) {
      formError = 'Please enter a valid 10 digit mobile number.';
      notifyListeners();
      return false;
    }
    if (selectedRelationship == null) {
      formError = 'Please select a relationship.';
      notifyListeners();
      return false;
    }

    _contacts.add(
      EmergencyContact(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        relationship: selectedRelationship!,
        phone: '+977 $phoneDigits',
      ),
    );

    formError = null;
    nameController.clear();
    phoneController.clear();
    selectedRelationship = null;
    notifyListeners();
    return true;
  }

  void removeContact(String id) {
    _contacts.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  void editContact(
      String id, {
        String? name,
        String? relationship,
        String? phone,
      }) {
    final index = _contacts.indexWhere((c) => c.id == id);
    if (index == -1) return;
    final contact = _contacts[index];
    if (name != null && name.trim().isNotEmpty) contact.name = name.trim();
    if (relationship != null) contact.relationship = relationship;
    if (phone != null && phone.trim().isNotEmpty) contact.phone = phone.trim();
    notifyListeners();
  }

  void setPrimary(String id) {
    for (final c in _contacts) {
      c.isPrimary = c.id == id;
    }
    notifyListeners();
  }

  /// Placeholder for actually placing a call. Hook this up to
  /// `url_launcher`'s `launchUrl(Uri(scheme: 'tel', path: phone))`.
  void callContact(String phone) {
    debugPrint('Calling $phone ...');
  }

  /// Placeholder for sending a trial SOS link. Hook this up to your
  /// backend / SMS gateway call.
  Future<bool> sendTestAlert() async {
    debugPrint('Dispatching test SOS alert to ${_contacts.length} contacts');
    await Future.delayed(const Duration(milliseconds: 600));
    return true;
  }

  void toggleSafetyCircle(bool value) {
    isSafetyCircleActive = value;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}