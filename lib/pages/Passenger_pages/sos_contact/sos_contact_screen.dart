import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/passenger_provider/sos_contact_provider.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/widgets/sos_contact_widgets.dart';


/// Passenger SOS — Trusted Safety Circle / Profile screen.
///
/// NOTE: This screen intentionally does NOT include a bottom navigation
/// bar — it's expected to be pushed/shown inside your own scaffold /
/// IndexedStack that already owns the bottom nav.
///
/// Usage (wrap somewhere above this screen, e.g. in main.dart):
/// ```dart
/// ChangeNotifierProvider(
///   create: (_) => PassengerSosContactProvider(),
///   child: const PassengerSosContactScreen(),
/// )
/// ```
class PassengerSosContactScreen extends StatelessWidget {
  const PassengerSosContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PassengerSosContactProvider>(
      builder: (context, provider, _) {
        // NOTE: Wrapped in `Material` because this screen has no Scaffold
        // of its own (the host screen owns that). Without a Material
        // ancestor, every InkWell / TextField / ElevatedButton inside
        // PassengerSosTopBar, ContactTile, RoundIconButton, SosTextField,
        // etc. throws "No Material widget found".
        return Material(
          color: CustomColor.background(context),
          child: Column(
            // NOTE: `stretch` (not the default `center`) so the Column
            // gives its children a bounded, full-width constraint.
            // Without this, width goes unbounded going down into
            // PassengerSosTopBar's Row and ContactTile's inner Row,
            // which is exactly what produced the "RenderFlex overflowed
            // by ~199809 pixels" / "~99224 pixels" errors.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PassengerSosTopBar(
                onNotificationsTap: () {},
                onProfileTap: () {},
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  children: [
                    TrustedSafetyCircleBanner(
                      isActive: provider.isSafetyCircleActive,
                    ),
                    const SizedBox(height: 24),
                    SectionHeaderRow(
                      title: 'Configured Contacts',
                      count: provider.contacts.length,
                      trailingLabel:
                      'Max ${PassengerSosContactProvider.maxTrustedContacts} Trusted',
                    ),
                    const SizedBox(height: 16),
                    ...provider.contacts.map(
                          (contact) => ContactTile(
                        contact: contact,
                        onCall: () => provider.callContact(contact.phone),
                        onEdit: () => _showEditContactSheet(
                          context,
                          provider,
                          contact,
                        ),
                        onDelete: () => _confirmDelete(
                          context,
                          provider,
                          contact,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    AddContactFormCard(
                      provider: provider,
                      onSubmit: () async {
                        final added = await provider.addContactFromForm();
                        if (added && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Trusted contact added.'),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    const VerifiedByBanner(
                      label: 'Verified by Nepal Police Highway Safety Protocol',
                    ),
                    const SizedBox(height: 16),
                    TestAlertDispatchCard(
                      onTestLink: () async {
                        final ok = await provider.sendTestAlert();
                        if (ok && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Test SOS link sent.'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmDelete(
      BuildContext context,
      PassengerSosContactProvider provider,
      EmergencyContact contact,
      ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: CustomColor.card(context),
        title: Text('Remove contact?',
            style: TextStyle(color: CustomColor.textPrimary(context))),
        content: Text(
          'Remove ${contact.name} from your Trusted Safety Circle?',
          style: TextStyle(color: CustomColor.textSecondary(context)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              provider.removeContact(contact.id);
              Navigator.pop(ctx);
            },
            child: const Text('Remove', style: TextStyle(color: CustomColor.danger)),
          ),
        ],
      ),
    );
  }

  void _showEditContactSheet(
      BuildContext context,
      PassengerSosContactProvider provider,
      EmergencyContact contact,
      ) {
    final nameCtrl = TextEditingController(text: contact.name);
    final phoneCtrl = TextEditingController(
      text: contact.phone.replaceFirst('+977', '').trim(),
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Contact',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.textPrimary(context),
                ),
              ),
              const SizedBox(height: 16),
              SosTextField(
                label: 'Full Name',
                controller: nameCtrl,
                hint: 'Full name',
                prefixIcon: Icons.badge_outlined,
              ),
              const SizedBox(height: 14),
              SosTextField(
                label: 'Mobile Number',
                controller: phoneCtrl,
                hint: '98XXXXXXXX',
                prefixText: '+977   ',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    provider.editContact(
                      contact.id,
                      name: nameCtrl.text,
                      phone: '+977 ${phoneCtrl.text.trim()}',
                    );
                    Navigator.pop(ctx);
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}