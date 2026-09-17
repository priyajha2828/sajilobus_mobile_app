import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/driver_provider/sos_provider.dart';
import '../../../resources/banner/custom_banner.dart';
import '../../../resources/bottom/driver_button.dart';
import '../../../resources/card/custom_card.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/header/custom_header.dart';
import '../../../resources/label/label.dart';
import '../../../resources/tile/custom_tile.dart';
import '../../../resources/widgets/custom_widgets.dart';


class EmergencyAssistanceScreen extends StatelessWidget {
  const EmergencyAssistanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EmergencyProvider>(
      builder: (context, provider, _) {
        final model = provider.model;

        if (provider.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: CustomColor.primary),
          );
        }

        return Scaffold(
          backgroundColor: CustomColor.bg_color(context),
          appBar: EmergencyAppBar(
            title: 'Emergency Assistance',
            avatarUrl: 'https://i.pravatar.cc/300?img=12',
            onBack: () => Navigator.of(context).maybePop(),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EmergencyHeroBanner(
                  channelLabel: 'PRIORITY CHANNEL 01',
                  liveBadge: 'CRITICAL LIVE',
                  title: 'EMERGENCY DISPATCH SYSTEM',
                  subtitle:
                  'Immediate multi-agency telemetry broadcast across Koshi Province Command.',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NetworkEscalationCard(),
                      const SizedBox(height: 20),

                      NumberedSectionLabel(
                        title: '1. SELECT EMERGENCY TYPE',
                        trailing: '1 Type Selected',
                      ),
                      const SizedBox(height: 10),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.55,
                        children: model.typeOptions.map((option) {
                          return EmergencyTypeTile(
                            option: option,
                            isSelected: model.selectedType == option.type,
                            onTap: () => provider.selectEmergencyType(option.type),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),

                      EmergencySectionCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TelemetryHeader(),
                            const SizedBox(height: 12),
                            PlateDesignationRow(
                              plateNepali: model.telemetry.plateNepali,
                              fleetDesignation: model.telemetry.fleetDesignation,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TelemetryInfoTile(
                                    label: 'Coordinates & Waypoint',
                                    value: Text(
                                      model.telemetry.coordinates,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: CustomColor.textPrimary(context),
                                      ),
                                    ),
                                    footnote: model.telemetry.waypointLabel,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TelemetryInfoTile(
                                    label: 'Passenger Manifest',
                                    value: Row(
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          '${model.telemetry.passengerCount}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: CustomColor.emergencyRedLight,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Souls aboard',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: CustomColor.textPrimary(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                    footnote: model.telemetry.capacityStatus,
                                    footnoteColor: CustomColor.success,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TelemetryInfoTile(
                                    label: 'Assigned Route',
                                    value: Text(
                                      '${model.telemetry.routeFrom} → ${model.telemetry.routeTo}',
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                        color: CustomColor.textPrimary(context),
                                      ),
                                    ),
                                    footnote: model.telemetry.transitLine,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TelemetryInfoTile(
                                    label: 'Duty Captain',
                                    value: Text(
                                      model.telemetry.dutyCaptainName,
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                        color: CustomColor.textPrimary(context),
                                      ),
                                    ),
                                    footnote: model.telemetry.dutyCaptainPhone,
                                    footnoteColor: CustomColor.accentBlue(context),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            MapPlaceholder(
                              locationLabel: model.telemetry.mapLocationLabel,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      QuickLogBox(
                        logText: model.quickLogText,
                        isRecording: model.isAudioLogging,
                        onAddAudio: provider.toggleAudioLogging,
                        tags: model.quickLogTags,
                      ),
                      const SizedBox(height: 20),

                      BroadcastSosButton(
                        isBroadcasting: provider.isBroadcasting,
                        onHoldComplete: provider.broadcastSOS,
                      ),
                      const SizedBox(height: 20),

                      DispatchPreviewCard(ticket: model.priorityTicket),
                      const SizedBox(height: 20),

                      Text(
                        '3. DIRECT EMERGENCY VOICE CHANNELS',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                          color: CustomColor.textSecondary(context),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: VoiceChannelTile(
                              channel: model.voiceChannels[0],
                              accentColor: CustomColor.accentBlue(context),
                              onTap: () => provider.callChannel(
                                  model.voiceChannels[0].number),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: VoiceChannelTile(
                              channel: model.voiceChannels[1],
                              accentColor: CustomColor.danger,
                              onTap: () {},
                          ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: VoiceChannelTile(
                              channel: model.voiceChannels[2],
                              accentColor: CustomColor.success,
                              onTap: () => provider?.callChannel(
                                  model.voiceChannels[2].number),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}