import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/passenger_provider/live_track_provider.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/widgets/live_track_widgets.dart';


/// Live Vehicle Tracker body.
///
/// This screen intentionally has NO Scaffold app bar — it's designed to be
/// dropped inside your existing navigation shell / bottom nav host, e.g.:
///
/// ```dart
/// ChangeNotifierProvider(
///   create: (_) => VehicleTrackerProvider()..startListening(),
///   child: const PassengerSosScreen(),
/// )
/// ```
class LiveTrackScreen extends StatelessWidget {
  const LiveTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VehicleTrackerProvider>();

    return Container(
      color: CustomColor.bg_color(context),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // ---- Map ----
                LiveMapPanel(
                  nextStopLabel: '${provider.nextStopName} (2m)',
                  vehiclePlate: provider.vehiclePlate,
                  onLocatePressed: provider.recenterMap,
                  onLayersPressed: () {},
                ),

                // ---- Top floating pills ----
                Positioned(
                  top: 12,
                  left: 12,
                  right: 12,
                  child: Row(
                    children: [
                      RoutePill(
                        routeNumber: provider.routeNumber,
                        from: provider.routeFrom,
                        to: provider.routeTo,
                      ),
                      const Spacer(),
                      GpsStatusBadge(
                        signalPercent: provider.gpsSignalPercent,
                        updatedSecondsAgo: provider.gpsLastUpdatedSeconds,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ---- Bottom sheet content ----
          Container(
            decoration: BoxDecoration(
              color: CustomColor.bg_color(context),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SheetDragHandle(),

                  // ---- Vehicle info ----
                  VehicleInfoCard(
                    vehiclePlate: provider.vehiclePlate,
                    fullPlateNumber: provider.fullPlateNumber,
                    driverName: provider.driverName,
                    serviceTag: provider.serviceTag,
                    isActive: provider.isActive,
                  ),
                  const SizedBox(height: 16),

                  // ---- Stat grid ----
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          label: 'ARRIVAL IN',
                          icon: Icons.access_time,
                          valueWidget: Text(
                            '${provider.arrivalEtaMinutes} mins',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: CustomColor.primary,
                            ),
                          ),
                          footer: 'Live ETA to pickup',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          label: 'DISTANCE',
                          icon: Icons.location_on_outlined,
                          valueWidget: Text(
                            '${provider.distanceKm} km',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: CustomColor.textPrimary(context),
                            ),
                          ),
                          footer: 'Speed: ${provider.speedKmh.toInt()} km/h',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          label: 'CROWD',
                          icon: Icons.people_outline,
                          valueWidget: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: CustomColor.textPrimary(context),
                              ),
                              children: [
                                TextSpan(text: '${provider.crowdCurrent}'),
                                TextSpan(
                                  text: ' / ${provider.crowdCapacity} seats',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: CustomColor.textSecondary(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailingContent:
                          CrowdProgressBar(ratio: provider.crowdRatio),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          label: 'NEXT STOP',
                          icon: Icons.navigation_outlined,
                          valueWidget: Text(
                            provider.nextStopName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: CustomColor.textPrimary(context),
                            ),
                          ),
                          footer: provider.nextStopStatus,
                          footerColor: CustomColor.success,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ---- Route milestones ----
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CustomColor.card(context),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: CustomColor.border(context)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ROUTE MILESTONES',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.4,
                                color: CustomColor.textMutedLabel(context),
                              ),
                            ),
                            Text(
                              '${provider.stopsRemaining} Stops Remaining',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: CustomColor.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        for (int i = 0; i < provider.milestones.length; i++)
                          MilestoneTile(
                            milestone: provider.milestones[i],
                            isLast: i == provider.milestones.length - 1,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ---- Bottom actions ----
                  Row(
                    children: [
                      Expanded(
                        child: BottomActionButton(
                          icon: Icons.notifications_none,
                          label: 'Alert',
                          background: CustomColor.secondaryActionBg(context),
                          foreground: CustomColor.secondaryActionText(context),
                          onTap: provider.sendAlert,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: BottomActionButton(
                          icon: Icons.share_outlined,
                          label: 'Share',
                          background: CustomColor.secondaryActionBg(context),
                          foreground: CustomColor.secondaryActionText(context),
                          onTap: provider.shareLiveLocation,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: BottomActionButton(
                          icon: Icons.sos,
                          label: 'SOS',
                          background: CustomColor.sosBg,
                          foreground: CustomColor.sosText,
                          onTap: provider.triggerSos,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}