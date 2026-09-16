import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/driver_provider/profile_provider.dart';
import '../../../resources/banner/driver_banner.dart';
import '../../../resources/bottom/driver_button.dart';
import '../../../resources/card/custom_card.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/header/custom_header.dart';
import '../../../resources/pill/driver_pill.dart';
import '../../../resources/tile/custom_tile.dart';
import '../../../resources/widgets/driver_widgets.dart';


class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DriverProfileProvider>(
      builder: (context, provider, _) {
        final profile = provider.profile;

        if (provider.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: CustomColor.primary),
          );
        }

        return Scaffold(
          backgroundColor: CustomColor.bg_color(context),
          body: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProfileHeader(profile: profile),
                      const SizedBox(height: 16),
                      _CredentialsSection(profile: profile),
                      const SizedBox(height: 16),
                      _PreferencesSection(profile: profile, provider: provider),
                      const SizedBox(height: 16),
                      _DispatchHelpSection(),
                      const SizedBox(height: 16),
                      LogoutButton(
                        isLoading: provider.isLoggingOut,
                        onTap: () => _confirmLogout(context, provider),
                      ),
                      const SizedBox(height: 12),
                      WarningBanner(
                        text: 'Logging out will set vehicle ',
                        highlight: '${profile.plateEnglish}  ',
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 16,
                bottom: 20,
                child: SosFab(onTap: provider.triggerSOS),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmLogout(BuildContext context, DriverProfileProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text(
            'This will set your vehicle to inactive on the dispatch radar. Continue?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              provider.logout(context);
            },
            child: const Text('Logout', style: TextStyle(color: CustomColor.danger)),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final dynamic profile;
  const _ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: CustomColor.border(context),
                backgroundImage: NetworkImage(profile.photoUrl),
              ),
              Positioned(
                bottom: -10,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: CustomColor.onlineGreen,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: CustomColor.card(context), width: 2),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, size: 8, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'ONLINE & ACTIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            profile.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: CustomColor.textPrimary(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${profile.role} • ${profile.division}',
            style: TextStyle(
              fontSize: 13,
              color: CustomColor.textSecondary(context),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: CustomColor.bg_color(context),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                StatColumn(
                  top: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded,
                          size: 16, color: CustomColor.starYellow),
                    ],
                  ),
                  value: '${profile.rating} /5.0',
                  label: '${profile.totalTrips} Trips',
                ),
                _StatDivider(),
                StatColumn(
                  top: Icon(Icons.verified_user_rounded,
                      size: 16, color: CustomColor.success),
                  value: '${profile.safetyScorePercent}%',
                  label: 'Safety Score',
                ),
                _StatDivider(),
                StatColumn(
                  top: Icon(Icons.access_time_rounded,
                      size: 16, color: CustomColor.accentBlue(context)),
                  value: profile.tenure,
                  label: 'Tenure',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 1,
      color: CustomColor.border(context),
    );
  }
}

class _CredentialsSection extends StatelessWidget {
  final dynamic profile;
  const _CredentialsSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            icon: Icons.badge_outlined,
            title: 'Credentials & Vehicle',
            trailing: PillBadge(text: profile.driverBadgeId),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: CustomColor.bg_color(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ASSIGNED BUS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: CustomColor.textSecondary(context),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.circle,
                            size: 6, color: CustomColor.success),
                        const SizedBox(width: 4),
                        Text(
                          profile.assignedBusLabel,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.textPrimary(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'नेपाल सरकार यातायात व्यवस्था',
                  style: TextStyle(
                      fontSize: 11, color: CustomColor.textSecondary(context)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      profile.plateNepali,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                    Text(
                      profile.plateEnglish,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: CustomColor.accentBlue(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 24),
          CredentialTile(
            icon: Icons.badge_outlined,
            label: 'Commercial License',
            value: profile.commercialLicense,
            verifiedSubtitle: profile.licenseValidTill,
          ),
          CredentialTile(
            icon: Icons.call_outlined,
            label: 'Registered Phone',
            value: profile.registeredPhone,
            valueColor: CustomColor.accentBlue(context),
            verifiedSubtitle: profile.otpVerified ? 'OTP Verified' : null,
          ),
          CredentialTile(
            icon: Icons.mail_outline,
            label: 'Fleet ID & Auth',
            value: profile.fleetEmail,
            valueColor: CustomColor.accentBlue(context),
            verifiedSubtitle:
            profile.firebaseAuthVerified ? 'Firebase Auth' : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.alt_route_outlined,
                    size: 18, color: CustomColor.textSecondary(context)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Default Route',
                    style: TextStyle(
                        fontSize: 13.5,
                        color: CustomColor.textSecondary(context)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      profile.routeFrom,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_forward,
                            size: 12, color: CustomColor.accentBlue(context)),
                        const SizedBox(width: 4),
                        Text(
                          profile.routeTo,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.textPrimary(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreferencesSection extends StatelessWidget {
  final dynamic profile;
  final DriverProfileProvider provider;
  const _PreferencesSection({required this.profile, required this.provider});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.tune_rounded,
            title: 'Preferences & Telematics',
          ),
          const SizedBox(height: 8),
          ToggleTile(
            icon: Icons.volume_up_outlined,
            title: 'In-Cab Audio Alerts',
            subtitle: 'Turn-by-turn guidance and dispatch announcements',
            value: profile.inCabAudioAlerts,
            onChanged: provider.toggleInCabAudioAlerts,
          ),
          ToggleTile(
            icon: Icons.speed_outlined,
            title: 'Speed Limit Warning Beep',
            subtitle: 'Audible alert at >50 km/h corridor threshold',
            value: profile.speedLimitWarningBeep,
            onChanged: provider.toggleSpeedLimitBeep,
          ),
          ActionChipTile(
            icon: Icons.nightlight_outlined,
            title: 'Night Driving Mode',
            subtitle: 'Auto switch display at local sunset',
            chipLabel: profile.nightDrivingMode,
          ),
          ActionChipTile(
            icon: Icons.translate_outlined,
            title: 'Interface Language',
            subtitle: 'Devanagari & Romanized dual mode',
            chipLabel: profile.interfaceLanguage,
          ),
          StatusIconTile(
            icon: Icons.cloud_done_outlined,
            title: 'Offline Map Cache',
            statusText:
            '${profile.offlineMapRegion} (${profile.offlineMapSizeCached})',
            statusColor: CustomColor.success,
            trailingIcon: Icons.refresh_rounded,
            onTrailingTap: provider.refreshOfflineMapCache,
          ),
        ],
      ),
    );
  }
}

class _DispatchHelpSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.headset_mic_outlined,
            title: 'Fleet Dispatch & Help',
          ),
          const SizedBox(height: 8),
          DispatchTile(
            icon: Icons.headset_mic_outlined,
            title: 'Contact Dispatch Operations',
            subtitle: '24/7 Itahari Fleet HQ Control Room',
            onTap: () {},
          ),
          DispatchTile(
            icon: Icons.shield_outlined,
            title: 'Driver Safety Protocol & Guidelines',
            subtitle: 'Monsoon, mountain terrain & passenger rules',
            onTap: () {},
          ),
          DispatchTile(
            icon: Icons.description_outlined,
            title: 'Terms of Fleet Service',
            subtitle: 'Nepal Motor Vehicles & Transit Act compliance',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}