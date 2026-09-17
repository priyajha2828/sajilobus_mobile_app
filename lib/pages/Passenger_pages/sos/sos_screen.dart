import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/passenger_provider/sos_provider.dart';
import '../../../resources/banner/custom_banner.dart';
import '../../../resources/bottom/custom_bottom.dart';
import '../../../resources/card/custom_card.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/header/custom_header.dart';
import '../../../resources/text_field/custom_textfield.dart';
import '../../../resources/tile/custom_tile.dart';
import '../../../resources/widgets/custom_widgets.dart';


/// NVTS Transit — "Live Vehicle Tracker" / Passenger SOS screen.
///
/// NOTE: This screen intentionally does NOT include a bottomNavigationBar —
/// it is expected to be pushed/shown inside your own navigation shell.
class PassengerSosScreen extends StatelessWidget {
  const PassengerSosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PassengerSosProvider(),
      child: const _PassengerSosBody(),
    );
  }
}

class _PassengerSosBody extends StatelessWidget {
  const _PassengerSosBody();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PassengerSosProvider>();
    final p = context.read<PassengerSosProvider>();

    final dispatchRows = [
      DispatchInfoRow(label: 'Primary Dispatch Unit:', value: provider.dispatchUnit),
      DispatchInfoRow(
        label: 'Dispatch Protocol:',
        value: provider.dispatchProtocol,
        isLink: true,
      ),
      DispatchInfoRow(
        label: 'Registered Family Alert:',
        value: provider.familyAlertLabel,
        leadingIcon: Icons.check_circle,
      ),
    ];

    return Scaffold(
      backgroundColor: CustomColor.background(context),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _TopBar(),
            EmergencyBanner(
              title: provider.bannerTitle,
              subtitle: provider.bannerSubtitle,
              isLive: provider.isLiveLine,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TelemetryStatusRow(
                            label: 'HIGH-PRECISION TELEMETRY\nLOCK',
                            accuracyLabel: provider.accuracyLabel,
                          ),
                          const SizedBox(height: 12),
                          GpsCoordinatesCard(
                            label: 'AUTO-DETECTED GPS COORDINATES',
                            coordinates: provider.gpsCoordinates,
                            subtext: provider.gpsSubtext,
                          ),
                          const SizedBox(height: 10),
                          VehicleTrackRow(
                            plateNumber: provider.vehiclePlate,
                            badge: provider.vehicleBadge,
                            routeLabel: provider.routeLabel,
                            speedLabel: provider.speedLabel,
                          ),
                          const SizedBox(height: 20),
                          AppCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'LIVE DISPATCH LIFECYCLE',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.3,
                                        color: CustomColor.textPrimary(context),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Stage ${provider.currentStage.index + 1} Active',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: CustomColor.danger,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                DispatchLifecycleStepper(
                                  currentStage: provider.currentStage,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SectionHeader1(
                            title: 'Nature of Emergency',
                            trailingText: 'Select one or more',
                          ),
                          const SizedBox(height: 10),
                          _EmergencyGrid(provider: provider),
                          const SizedBox(height: 20),
                          SectionHeader1(
                            title: 'Incident Details (Optional)',
                            trailingText: 'Voice or text',
                          ),
                          const SizedBox(height: 10),
                          VoiceTextField(
                            controller: provider.descriptionController,
                            hint: 'Optional details for control room & emergency contacts...',
                            onChanged: p.updateDescription,
                            onMicTap: p.startVoiceInput,
                          ),
                          const SizedBox(height: 22),
                          CriticalResponsePanel(
                            holdProgress: provider.holdProgress,
                            isHolding: provider.isHolding,
                            activated: provider.sosActivated,
                            onHoldStart: p.startHold,
                            onHoldEnd: p.cancelHold,
                            policeContactLabel: provider.policeContactLabel,
                            emergencyContactCount: provider.emergencyContactCount,
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: CallActionButton(
                                  icon: Icons.call,
                                  iconColor: CustomColor.callPoliceIcon(context),
                                  background: CustomColor.callPoliceBg(context),
                                  title: 'Call ${provider.policeHotline}',
                                  subtitle: 'Nepal Police Hot-Line',
                                  onTap: () => p.callNumber(provider.policeHotline),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CallActionButton(
                                  icon: Icons.traffic_outlined,
                                  iconColor: CustomColor.callTrafficIcon(context),
                                  background: CustomColor.callTrafficBg(context),
                                  title: 'Call ${provider.trafficPoliceLine}',
                                  subtitle: 'Traffic Police Ops',
                                  onTap: () => p.callNumber(provider.trafficPoliceLine),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          DispatchPreviewCard1(
                            title: 'Central Transit Dispatch Preview',
                            rows: dispatchRows,
                            channelLabel: provider.channelLabel,
                            onSettingsTap: p.openDispatchSettings,
                          ),
                          const SizedBox(height: 18),
                          Center(
                            child: InkWell(
                              onTap: p.returnToNavigation,
                              child: Text(
                                'Accidental Tap? Return to Navigation Safely',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColor.footerLinkColor(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Top bar (light header, matches the NVTS Transit passenger app)
// ---------------------------------------------------------------------
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.fromLTRB(8, 8, 16, 10),
      decoration: BoxDecoration(
        color: CustomColor.transitHeaderBg(context),
        border: Border(bottom: BorderSide(color: CustomColor.border(context))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(Icons.arrow_back, color: CustomColor.textPrimary(context)),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: CustomColor.primary,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(Icons.directions_bus_filled_outlined,
                color: CustomColor.onDark, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Live Vehicle Tracker',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: CustomColor.textPrimary(context),
              ),
            ),
          ),
          CircleAvatar(
            radius: 17,
            backgroundColor: CustomColor.onDarkFaint,
            child: Icon(Icons.person, color: CustomColor.textPrimary(context)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// "Nature of Emergency" 2x2 grid
// ---------------------------------------------------------------------
class _EmergencyGrid extends StatelessWidget {
  final PassengerSosProvider provider;
  const _EmergencyGrid({required this.provider});

  @override
  Widget build(BuildContext context) {
    final p = context.read<PassengerSosProvider>();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.emergencyTypes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.4,
      ),
      itemBuilder: (context, index) {
        final item = provider.emergencyTypes[index];
        return EmergencyTypeTile1(
          icon: item.icon,
          label: item.label,
          subtitle: item.subtitle,
          selected: provider.selectedEmergencyIndex == index,
          onTap: () => p.selectEmergencyType(index),
        );
      },
    );
  }
}