import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/driver_provider/stop_management_provider.dart';
import '../../../resources/badge/badge.dart';
import '../../../resources/bar/driver_bar.dart';
import '../../../resources/bottom/driver_button.dart';
import '../../../resources/card/driver_card.dart';
import '../../../resources/chip/driver_chip.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/tile/custom_tile.dart';
import '../../../routes/app_route.dart';



/// Stop Management screen from FleetTrack.
///
/// NOTE: This screen intentionally does NOT include a bottomNavigationBar —
/// it is expected to be pushed/shown inside your own navigation shell
/// (the one with Dashboard / Trip / Notifications / Profile).
///
/// Wire the provider once, e.g. in main.dart:
///
/// ```dart
/// ChangeNotifierProvider(
///   create: (_) => StopManagementProvider(),
///   child: const MyApp(),
/// )
/// ```
class StopManagementScreen extends StatelessWidget {
  const StopManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StopManagementProvider(),
      child: const _StopManagementBody(),
    );
  }
}

class _StopManagementBody extends StatelessWidget {
  const _StopManagementBody();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StopManagementProvider>();

    return Scaffold(
      backgroundColor: CustomColor.background(context),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _Header(provider: provider)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CurrentStopCard(provider: provider),
                      const SizedBox(height: 14),
                      OccupancyBar(
                        current: provider.occupancyCurrent,
                        max: provider.occupancyMax,
                        percent: provider.occupancyPercent,
                        percentInt: provider.occupancyPercentInt,
                      ),
                      const SizedBox(height: 14),
                      _StatsRow(provider: provider),
                      const SizedBox(height: 14),
                      PrimaryActionButton(
                        label: 'Depart Stop & Confirm Boarding',
                        icon: Icons.directions_bus_filled_outlined,
                        background: CustomColor.departButtonBg(context),
                        onTap: () => context
                            .read<StopManagementProvider>()
                            .departStopAndConfirmBoarding(),
                      ),
                      const SizedBox(height: 10),
                      PrimaryActionButton(
                        label: 'Notify Waiting Passengers (SMS/App Beacon)',
                        icon: Icons.campaign_outlined,
                        background: CustomColor.notifyButtonBg(context),
                        onTap: () => context
                            .read<StopManagementProvider>()
                            .notifyWaitingPassengers(),
                      ),
                      const SizedBox(height: 18),
                      _NextStopCard(provider: provider),
                      const SizedBox(height: 18),
                      _CorridorTimelineHeader(provider: provider),
                      const SizedBox(height: 10),
                      _CorridorTimelineCard(provider: provider),
                      const SizedBox(height: 14),
                      _ControlRoomCard(provider: provider),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 24,
            child: SosButton(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.sos);
              },

            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Header (dark navy top section)
// ---------------------------------------------------------------------
class _Header extends StatelessWidget {
  final StopManagementProvider provider;
  const _Header({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.headerBg(context),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: CustomColor.onDarkTint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.local_shipping_outlined,
                    color: CustomColor.onDark, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'FleetTrack',
                          style: TextStyle(
                            color: CustomColor.onDark,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: CustomColor.onlineDot,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'ONLINE',
                          style: TextStyle(
                            color: CustomColor.onlineDot,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Active Route',
                      style: TextStyle(
                        color: CustomColor.onDarkMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 18,
                backgroundColor: CustomColor.onDarkFaint,
                child: Icon(Icons.person, color: CustomColor.onDark),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            provider.lineLabel,
            style: TextStyle(
              color: CustomColor.headerAccentLine(context),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Stop Management',
                      style: TextStyle(
                        color: CustomColor.onDark,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${provider.corridorName} • ${provider.routeArea}',
                      style: TextStyle(
                        color: CustomColor.onDarkMuted,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: CustomColor.warning,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      provider.busPlate,
                      style: const TextStyle(
                        color: CustomColor.onWarning,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      provider.busNumber,
                      style: const TextStyle(
                        color: CustomColor.onWarning,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: CustomColor.headerAccentLine(context),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Current stop card
// ---------------------------------------------------------------------
class _CurrentStopCard extends StatelessWidget {
  final StopManagementProvider provider;
  const _CurrentStopCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return AppCard1(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              InfoBadge(
                label:
                'CURRENT STOP (STOP ${provider.currentStopIndex} OF ${provider.totalStops})',
                icon: Icons.location_on,
                background: CustomColor.badgeBlueBg(context),
                foreground: CustomColor.badgeBlueText(context),
              ),
              if (provider.isLiveGeoFenced)
                InfoBadge(
                  label: 'LIVE GEO-FENCED',
                  icon: Icons.sync,
                  background: CustomColor.badgeGreenBg(context),
                  foreground: CustomColor.badgeGreenText(context),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  provider.stopName,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    provider.currentTime,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: CustomColor.timelineActive,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                  Text(
                    provider.scheduleDeltaMinutes >= 0
                        ? '+${provider.scheduleDeltaMinutes}m On Schedule'
                        : '${provider.scheduleDeltaMinutes}m Delayed',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: provider.scheduleDeltaMinutes >= 0
                          ? CustomColor.success
                          : CustomColor.danger,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            provider.stopSubLocation,
            style: TextStyle(
              fontSize: 13,
              color: CustomColor.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Waiting / Boarded / Dropped stats row
// ---------------------------------------------------------------------
class _StatsRow extends StatelessWidget {
  final StopManagementProvider provider;
  const _StatsRow({required this.provider});

  @override
  Widget build(BuildContext context) {
    final p = context.read<StopManagementProvider>();
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StatCounterTile(
              icon: Icons.hourglass_bottom,
              label: 'WAITING',
              value: '${provider.waitingCount}',
              background: CustomColor.waitingTileBg(context),
              accent: CustomColor.textPrimary(context),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: StatCounterTile(
              icon: Icons.person_add_alt_1,
              label: 'BOARDED',
              value: '+${provider.boardedDelta}',
              background: CustomColor.boardedTileBg(context),
              accent: CustomColor.boardedAccent(context),
              showControls: true,
              onIncrement: p.incrementBoarded,
              onDecrement: p.decrementBoarded,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: StatCounterTile(
              icon: Icons.logout,
              label: 'DROPPED',
              value: '-${provider.droppedDelta}',
              background: CustomColor.droppedTileBg(context),
              accent: CustomColor.droppedAccent(context),
              showControls: true,
              onIncrement: p.incrementDropped,
              onDecrement: p.decrementDropped,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Next stop upcoming card
// ---------------------------------------------------------------------
class _NextStopCard extends StatelessWidget {
  final StopManagementProvider provider;
  const _NextStopCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return AppCard1(
      color: CustomColor.nextStopCardBg(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.directions_bus_outlined,
                  size: 16, color: CustomColor.iconMuted(context)),
              const SizedBox(width: 6),
              Text(
                'NEXT STOP UPCOMING',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: CustomColor.textMutedLabel(context),
                ),
              ),
              const Spacer(),
              TagChip(
                label: 'Stage ${provider.nextStopStage}',
                background: CustomColor.stageBadgeBg(context),
                foreground: CustomColor.textSecondary(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  provider.nextStopName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${provider.nextStopEtaMinutes} min',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: CustomColor.timelineActive,
                    ),
                  ),
                  Text(
                    '${provider.nextStopDistanceKm} km ahead',
                    style: TextStyle(
                      fontSize: 11,
                      color: CustomColor.textSecondary(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            provider.nextStopSub,
            style: TextStyle(
              fontSize: 12,
              color: CustomColor.textSecondary(context),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: CustomColor.chipBg(context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.confirmation_num_outlined,
                          size: 14, color: CustomColor.chipText(context)),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          '${provider.prebookedTickets} tickets pre-booked online',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.chipText(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.graphic_eq, size: 14),
                label: const Text('Chime Audio', style: TextStyle(fontSize: 11)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: CustomColor.textPrimary(context),
                  side: BorderSide(color: CustomColor.border(context)),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Corridor timeline header
// ---------------------------------------------------------------------
class _CorridorTimelineHeader extends StatelessWidget {
  final StopManagementProvider provider;
  const _CorridorTimelineHeader({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.alt_route, size: 18, color: CustomColor.textPrimary(context)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            'Corridor Timeline',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: CustomColor.textPrimary(context),
            ),
          ),
        ),
        Text(
          '${provider.waypoints.length} Manifest Waypoints',
          style: TextStyle(
            fontSize: 11,
            color: CustomColor.textSecondary(context),
          ),
        ),
      ],
    );
  }
}

class _CorridorTimelineCard extends StatelessWidget {
  final StopManagementProvider provider;
  const _CorridorTimelineCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          for (int i = 0; i < provider.waypoints.length; i++)
            TimelineTile(
              waypoint: provider.waypoints[i],
              isLast: i == provider.waypoints.length - 1,
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Control room contact card
// ---------------------------------------------------------------------
class _ControlRoomCard extends StatelessWidget {
  final StopManagementProvider provider;
  const _ControlRoomCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: CustomColor.chipBg(context),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.support_agent,
                color: CustomColor.chipText(context)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.controlRoomName,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                Text(
                  provider.controlRoomSub,
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: CustomColor.sos,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.call, color: CustomColor.onDark, size: 18),
          ),
        ],
      ),
    );
  }
}