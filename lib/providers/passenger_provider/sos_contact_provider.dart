import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sajilo_bus/config/dio_client.dart';

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
    fetchContactsFromBackend();
  }

  static const int maxTrustedContacts = 2;

  bool isSafetyCircleActive = true;
  bool isLoading = false;

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

  Future<void> fetchContactsFromBackend() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");
      if (token != null && token.isNotEmpty) {
        final res = await DioClient.dio.get(
          "/sos-contacts",
          options: Options(headers: {"Authorization": "Bearer $token"}),
        );
        if (res.statusCode == 200 && res.data["success"] == true) {
          final list = res.data["contacts"] as List?;
          if (list != null) {
            _contacts.clear();
            for (int i = 0; i < list.length; i++) {
              final item = list[i];
              _contacts.add(EmergencyContact(
                id: item["id"].toString(),
                name: item["contactName"] ?? "Contact",
                relationship: item["relationship"] ?? "Family",
                phone: item["contactNumber"] ?? "",
                isPrimary: i == 0,
              ));
            }
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching SOS contacts from backend: $e");
    } finally {
      if (_contacts.isEmpty) {
        _contacts.addAll([
          EmergencyContact(
            id: 'c1',
            name: 'Ramesh Rai',
            relationship: 'Father',
            phone: '+977 9842012345',
            isPrimary: true,
          ),
          EmergencyContact(
            id: 'c2',
            name: 'Anisha Shrestha',
            relationship: 'Sister',
            phone: '+977 9819876543',
          ),
        ]);
      }
      notifyListeners();
    }
  }

  /// Validates and adds a new trusted contact from the form fields.
  Future<bool> addContactFromForm() async {
    final name = nameController.text.trim();
    final phoneDigits = phoneController.text.trim();

    if (!canAddMoreContacts) {
      formError = 'You can only add up to 2 emergency contacts.';
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

    final fullPhone = '+977 $phoneDigits';

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");
      if (token != null && token.isNotEmpty) {
        await DioClient.dio.post(
          "/sos-contacts",
          data: {
            "contactName": name,
            "contactNumber": fullPhone,
            "relationship": selectedRelationship,
          },
          options: Options(headers: {"Authorization": "Bearer $token"}),
        );
      }
    } catch (e) {
      debugPrint("Error saving contact to backend: $e");
    }

    _contacts.add(
      EmergencyContact(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        relationship: selectedRelationship!,
        phone: fullPhone,
        isPrimary: _contacts.isEmpty,
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