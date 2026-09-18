import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/passenger_provider/profile_provider.dart';
import '../../../resources/card/custom_card.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/widgets/profile_widgets.dart';



/// Profile screen body. Does NOT include a bottom navigation bar — plug this
/// in as the body/tab content of your own Scaffold + BottomNavigationBar.
///
/// Usage:
///   ChangeNotifierProvider(
///     create: (_) => ProfileProvider(),
///     child: const ProfileScreen(),
///   )
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

  // ---------------------------------------------------------------------
  // AppBar
  // ---------------------------------------------------------------------
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
                'Profile',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.textSecondary(context),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: CustomColor.iconCircleBg(context),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.notifications_none_rounded,
                  size: 19, color: CustomColor.textPrimary(context)),
            ),
            Positioned(
              top: 6,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: CustomColor.notificationDot,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        CircleAvatar(
          radius: 18,
          backgroundColor: CustomColor.iconCircleBg(context),
          backgroundImage: const NetworkImage(
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&q=80',
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // Profile card (avatar, name, verified chip, email, phone, QR)
  // ---------------------------------------------------------------------
  Widget _buildProfileCard(BuildContext context, ProfileProvider provider) {
    return SectionCard2(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: CustomColor.iconCircleBg(context),
                backgroundImage: NetworkImage(provider.avatarUrl),
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: CustomColor.editBadgeBg,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: CustomColor.card(context), width: 2),
                  ),
                  child: const Icon(Icons.edit, size: 11, color: Colors.white),
                ),
              ),
            ],
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
          Icon(Icons.qr_code_2_rounded,
              size: 22, color: CustomColor.textSecondary(context)),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Transit card (gradient)
  // ---------------------------------------------------------------------
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

  // ---------------------------------------------------------------------
  // Emergency Safety Circle card
  // ---------------------------------------------------------------------
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
          Row(
            children: [
              Text(
                'Manage',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.primary,
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  size: 18, color: CustomColor.primary),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Authentication & Security Log card
  // ---------------------------------------------------------------------
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
            label: 'Terminal Region',
            value: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on_outlined,
                    size: 13, color: CustomColor.success),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '${provider.terminalRegionStatus} • ${provider.terminalRegion}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const RowDivider(),
          KeyValueRow(
            label: 'Session Device',
            value: Text(
              provider.sessionDevice,
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

  // ---------------------------------------------------------------------
  // App & Travel Preferences card
  // ---------------------------------------------------------------------
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
          const RowDivider(),
          LanguageToggleTile(
            icon: Icons.translate_rounded,
            title: 'Language / भाषा',
            subtitleSelected:
            'Selected: ${provider.isEnglish ? "English" : "नेपाली"}',
            isEnglish: provider.isEnglish,
            onChanged: (v) => context.read<ProfileProvider>().setLanguage(v),
          ),
          const RowDivider(),
          ToggleTile(
            icon: Icons.contrast_rounded,
            title: 'Outdoor High Contrast Mode',
            subtitle: 'Enhanced sunlight route legibility',
            value: provider.highContrastMode,
            onChanged: (v) =>
                context.read<ProfileProvider>().toggleHighContrastMode(v),
          ),
          const RowDivider(),
          ToggleTile(
            icon: Icons.volume_up_outlined,
            title: 'Audio Stop Announcements',
            subtitle: 'Spoken upcoming stop alarms',
            value: provider.audioAnnouncements,
            onChanged: (v) =>
                context.read<ProfileProvider>().toggleAudioAnnouncements(v),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Help & Official Transit Desk card
  // ---------------------------------------------------------------------
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
          const RowDivider(),
          ActionRow(
            leadingIcon: Icons.privacy_tip_outlined,
            leadingIconBg: CustomColor.sectionIconBg(context),
            leadingIconColor: CustomColor.primary,
            title: provider.privacyPolicyLabel,
            trailing: Icon(Icons.open_in_new_rounded,
                size: 16, color: CustomColor.textSecondary(context)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Logout button
  // ---------------------------------------------------------------------
  Widget _buildLogoutButton(BuildContext context, ProfileProvider provider) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: () => context.read<ProfileProvider>().logout(),
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColor.logoutBg(context),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: const Icon(Icons.logout_rounded,
            size: 18, color: CustomColor.logoutText),
        label: const Text(
          'Logout from Firebase',
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