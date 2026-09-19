import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../providers/passenger_provider/profile_provider.dart';
import '../../../resources/card/custom_card.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/widgets/profile_widgets.dart';
import '../../../services/auth_services.dart';

class PassengerProfileScreen extends StatelessWidget {
  const PassengerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            _buildProfileCard(context, provider),
            const SizedBox(height: 16),
            _buildTransitCard(context, provider),
            const SizedBox(height: 16),
            _buildEmergencyCard(context, provider),
            const SizedBox(height: 16),
            _buildSecurityLogCard(context, provider),
            const SizedBox(height: 16),
            _buildPreferencesCard(context, provider),
            const SizedBox(height: 16),
            _buildFeedbackCard(context, provider),
            const SizedBox(height: 16),
            _buildHelpDeskCard(context, provider),
            const SizedBox(height: 20),
            _buildLogoutButton(context, provider),
            const SizedBox(height: 16),
            Center(
              child: Text(
                provider.appFooter,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: CustomColor.textSecondary(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.appBarBg(context),
      elevation: 0,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: CustomColor.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.directions_bus_rounded,
                color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sajilo Bus',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: CustomColor.textPrimary(context),
                ),
              ),
              Text(
                'Passenger Profile',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.textSecondary(context),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Builder(
          builder: (context) {
            final provider = context.watch<ProfileProvider>();
            return GestureDetector(
              onTap: () => _showPhotoOptions(context, provider),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: CustomColor.iconCircleBg(context),
                backgroundImage: provider.localPhotoFile != null
                    ? FileImage(provider.localPhotoFile!) as ImageProvider
                    : NetworkImage(provider.avatarUrl),
              ),
            );
          },
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context, ProfileProvider provider) {
    return SectionCard2(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _showPhotoOptions(context, provider),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: CustomColor.iconCircleBg(context),
                  backgroundImage: provider.localPhotoFile != null
                      ? FileImage(provider.localPhotoFile!) as ImageProvider
                      : NetworkImage(provider.avatarUrl),
                ),
                if (provider.isUploadingPhoto)
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: CustomColor.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: CustomColor.bg_color(context), width: 2),
                    ),
                    child: const Icon(Icons.camera_alt_rounded,
                        size: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 6),
                StatusChip(
                  label: provider.verifiedIdLabel,
                  bg: CustomColor.verifiedBg(context),
                  textColor: CustomColor.verifiedText,
                  icon: Icons.check_circle,
                ),
                IconTextRow(icon: Icons.email_outlined, text: provider.email),
                IconTextRow(icon: Icons.call_outlined, text: provider.phone),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPhotoOptions(BuildContext context, ProfileProvider provider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(ctx);
                provider.pickAndUpdatePhoto(fromCamera: true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(ctx);
                provider.pickAndUpdatePhoto(fromCamera: false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransitCard(BuildContext context, ProfileProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: CustomColor.transitCardGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.sensors_rounded,
                    size: 14, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                provider.transitCardTitle,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              StatusChip(
                label: provider.cardStatus,
                bg: CustomColor.transitCardActiveBg,
                textColor: CustomColor.transitCardActiveText,
              ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pass Card Number',
                        style: TextStyle(
                            fontSize: 12,
                            color: CustomColor.transitCardMuted)),
                    const SizedBox(height: 4),
                    Text(
                      provider.cardNumber,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Current Balance',
                      style:
                      TextStyle(fontSize: 12, color: CustomColor.transitCardMuted)),
                  const SizedBox(height: 4),
                  Text(
                    provider.currentBalance,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyCard(BuildContext context, ProfileProvider provider) {
    return SectionCard(
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: CustomColor.sosBg,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'SOS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: CustomColor.sosIcon,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Emergency Safety Circle',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${provider.trustedContactsCount} Trusted SOS Contacts Configured',
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityLogCard(BuildContext context, ProfileProvider provider) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            icon: Icons.shield_outlined,
            title: 'Authentication & Security Log',
            trailing: StatusChip(
              label: provider.sessionState,
              bg: CustomColor.liveSessionBg(context),
              textColor: CustomColor.liveSessionText,
              showDot: true,
            ),
          ),
          const SizedBox(height: 14),
          const RowDivider(),
          KeyValueRow(
            label: 'Last Successful Login',
            value: Text(
              provider.lastLogin,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textPrimary(context)),
            ),
          ),
          const RowDivider(),
          KeyValueRow(
            label: 'Firebase Auth UID',
            value: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: CustomColor.pillBg(context),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                provider.firebaseAuthUid,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard(BuildContext context, ProfileProvider provider) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.tune_rounded,
            title: 'App & Travel Preferences',
          ),
          const SizedBox(height: 6),
          const RowDivider(),
          ToggleTile(
            icon: Icons.notifications_active_outlined,
            title: 'Push Notifications',
            subtitle: 'Bus arrival and route alerts',
            value: provider.pushNotifications,
            onChanged: (v) =>
                context.read<ProfileProvider>().togglePushNotifications(v),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard(BuildContext context, ProfileProvider provider) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.rate_review_outlined,
            title: 'Feedback & Ratings',
          ),
          const SizedBox(height: 6),
          const RowDivider(),
          ActionRow(
            leadingIcon: Icons.star_outline_rounded,
            leadingIconBg: CustomColor.sectionIconBg(context),
            leadingIconColor: CustomColor.primary,
            title: 'Submit App & Service Feedback',
            subtitle: 'Rate your bus transit experience',
            trailing: const Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Colors.grey),
            onTap: () => _showFeedbackDialog(context, provider),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context, ProfileProvider provider) {
    double rating = 5.0;
    String category = 'General';
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: const Row(
                children: [
                  Icon(Icons.feedback_rounded, color: CustomColor.primary),
                  SizedBox(width: 8),
                  Text('Give Feedback', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rating', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < rating ? Icons.star_rounded : Icons.star_outline_rounded,
                            color: Colors.amber,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              rating = index + 1.0;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    const Text('Category', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: category,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      items: ['General', 'Bus Condition', 'Driver Conduct', 'App Issue', 'Route Schedule']
                          .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => category = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text('Comment / Experience', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: commentController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Share your experience or suggestions...',
                        hintStyle: const TextStyle(fontSize: 13),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () async {
                    final success = await provider.submitFeedback(
                      rating: rating,
                      category: category,
                      comment: commentController.text.trim(),
                    );
                    if (dialogCtx.mounted) {
                      Navigator.of(dialogCtx).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            success
                                ? 'Thank you! Your feedback has been submitted.'
                                : 'Failed to submit feedback. Please try again.',
                          ),
                          backgroundColor: success ? Colors.green : Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildHelpDeskCard(BuildContext context, ProfileProvider provider) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.support_agent_rounded,
            title: 'Help & Official Transit Desk',
          ),
          const SizedBox(height: 6),
          const RowDivider(),
          ActionRow(
            leadingIcon: Icons.call_outlined,
            leadingIconBg: CustomColor.sectionIconBg(context),
            leadingIconColor: CustomColor.primary,
            title: provider.helplineLabel,
            subtitle: provider.helplineNumber,
            trailing: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: CustomColor.verifiedBg(context),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.call_rounded,
                  size: 15, color: CustomColor.success),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, ProfileProvider provider) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: () async {
          await AuthService().logout();
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();
          if (context.mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil('/loginpage', (route) => false);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColor.logoutBg(context),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: const Icon(Icons.logout_rounded,
            size: 18, color: CustomColor.logoutText),
        label: const Text(
          'Logout from Account',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: CustomColor.logoutText,
          ),
        ),
      ),
    );
  }
}