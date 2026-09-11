import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/driver_provider/trip_provider.dart';
import '../../../resources/banner/driver_banner.dart';
import '../../../resources/bottom/driver_button.dart';
import '../../../resources/card/driver_card.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/pill/driver_pill.dart';
import '../../../resources/tile/custom_tile.dart';


/// FleetTrack "Active Route" trip screen.
///
/// NOTE: This screen only builds the page body — it does NOT include a
/// Scaffold bottomNavigationBar, since the host app supplies its own
/// bottom navigation and simply swaps this screen into its body/IndexedStack.
///
/// Wrap this in a ChangeNotifierProvider<TripProvider> higher up the tree
/// (e.g. around your bottom-nav host widget), or wrap just this screen:
///
/// ChangeNotifierProvider(
///   create: (_) => TripProvider(),
///   child: const TripScreen(),
/// )
class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      body: SafeArea(
        bottom: false,
        child: Consumer<TripProvider>(
          builder: (context, trip, _) {
            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  children: [
                    _Header(trip: trip),
                    const SizedBox(height: 14),
                    _RouteBanner(trip: trip),
                    const SizedBox(height: 14),
                    _StatCardsGrid(trip: trip),
                    const SizedBox(height: 14),
                    InfoBanner(
                      durationLabel: trip.durationElapsedLabel,
                      stopsRemaining: trip.stopsRemaining,
                    ),
                    const SizedBox(height: 14),
                    _MapCard(trip: trip),
                    const SizedBox(height: 18),
                    _StopTimelineSection(trip: trip),
                    const SizedBox(height: 18),
                    _DriverActionsCard(trip: trip),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Top app-style header: "FleetTrack ● ONLINE / Active Route" + avatar.
class _Header extends StatelessWidget {
  final TripProvider trip;
  const _Header({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: CustomColor.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.directions_bus_filled, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'SajiloBus',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (trip.driverOnline) const StatusPill(label: 'ONLINE'),
                ],
              ),
              Text(
                'Active Route',
                style: TextStyle(
                  fontSize: 12.5,
                  color: CustomColor.textSecondary(context),
                ),
              ),
            ],
          ),
        ),
        const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xFFE5E7EB),
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/100?img=12',
          ),
        ),
      ],
    );
  }
}

/// "Biratnagar → Itahari  ● LIVE GPS ON" + road name + route code row.
class _RouteBanner extends StatelessWidget {
  final TripProvider trip;
  const _RouteBanner({required this.trip});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.navigation, size: 17, color: CustomColor.primary),
                  const SizedBox(width: 8),
                  Text(
                    '${trip.originCity} → ${trip.destinationCity}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                ],
              ),
              if (trip.liveGpsOn)
                StatusPill(label: 'LIVE GPS ON', leadingIcon: Icons.gps_fixed),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 15, color: CustomColor.textMutedLabel(context)),
                  const SizedBox(width: 4),
                  Text(
                    trip.roadName,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: CustomColor.textSecondary(context),
                    ),
                  ),
                ],
              ),
              Text(
                trip.routeCode,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textMutedLabel(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 2x2 grid of SPEED / PASSENGERS / DISTANCE REM. / ETA stat cards.
class _StatCardsGrid extends StatelessWidget {
  final TripProvider trip;
  const _StatCardsGrid({required this.trip});

  @override
  Widget build(BuildContext context) {
    final speedProgress = trip.currentSpeed / (trip.speedLimit == 0 ? 1 : trip.speedLimit);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.speed,
                label: 'SPEED',
                trailingBadge: LimitBadge(limit: trip.speedLimit),
                valueRow: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${trip.currentSpeed} ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: CustomColor.textPrimary(context),
                        ),
                      ),
                      TextSpan(
                        text: 'km/h',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: CustomColor.textSecondary(context),
                        ),
                      ),
                    ],
                  ),
                ),
                footer: SpeedProgressBar(progress: speedProgress),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                icon: Icons.groups_outlined,
                label: 'PASSENGERS',
                valueRow: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${trip.passengersOnboard} ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: CustomColor.textPrimary(context),
                        ),
                      ),
                      TextSpan(
                        text: '/ ${trip.passengerCapacity}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.textSecondary(context),
                        ),
                      ),
                    ],
                  ),
                ),
                footer: Row(
                  children: [
                    const Icon(Icons.circle, size: 8, color: CustomColor.success),
                    const SizedBox(width: 6),
                    Text(
                      '${trip.vacantSeats} vacant seats',
                      style: TextStyle(
                        fontSize: 12,
                        color: CustomColor.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.social_distance,
                label: 'DISTANCE REM.',
                valueRow: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${trip.distanceRemainingKm.toStringAsFixed(1)} ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: CustomColor.textPrimary(context),
                        ),
                      ),
                      TextSpan(
                        text: 'km',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: CustomColor.textSecondary(context),
                        ),
                      ),
                    ],
                  ),
                ),
                footer: Text(
                  '${trip.distanceCoveredKm.toStringAsFixed(1)} km covered',
                  style: TextStyle(fontSize: 12, color: CustomColor.textSecondary(context)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                icon: Icons.access_time,
                label: 'ETA',
                valueRow: Text(
                  '${trip.etaMinutes} mins',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                footer: Text(
                  'Arr ~ ${trip.etaArrivalTime}${trip.isOnTime ? " (On-time)" : ""}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.success,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Map card: faux map surface + floating controls + next-direction banner.
class _MapCard extends StatelessWidget {
  final TripProvider trip;
  const _MapCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.mapSurface(context),
          border: Border.all(color: CustomColor.border(context)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 8, color: CustomColor.success),
                  const SizedBox(width: 6),
                  Text(
                    trip.currentRoadSegment,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                ],
              ),
            ),
            // Replace this SizedBox with your real map widget
            // (google_maps_flutter / mapbox_gl / flutter_map, etc).
            SizedBox(
              height: 230,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: CustomColor.mapFill(context),
                    child: Center(
                      child: Icon(
                        Icons.map_outlined,
                        size: 48,
                        color: CustomColor.textMutedLabel(context).withOpacity(0.4),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Column(
                      children: [
                        MapControlButton(icon: Icons.my_location, onTap: () {}),
                        const SizedBox(height: 8),
                        MapControlButton(
                          icon: Icons.traffic,
                          active: trip.trafficSignalActive,
                          onTap: () {},
                        ),
                        const SizedBox(height: 8),
                        MapControlButton(icon: Icons.add, onTap: () {}),
                        const SizedBox(height: 8),
                        MapControlButton(icon: Icons.remove, onTap: () {}),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: NextDirectionBanner(
                      instruction: trip.nextDirectionText,
                      distance: trip.nextDirectionDistance,
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

/// "Route Stop Timeline" heading + list card.
class _StopTimelineSection extends StatelessWidget {
  final TripProvider trip;
  const _StopTimelineSection({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Route Stop Timeline',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: CustomColor.textPrimary(context),
              ),
            ),
            Text(
              'Stop ${trip.currentStopIndex} of ${trip.totalStops}',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: CustomColor.textSecondary(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AppCard(
          child: Column(
            children: [
              for (int i = 0; i < trip.stops.length; i++)
                RouteStopTile(
                  stop: trip.stops[i],
                  isLast: i == trip.stops.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Driver Cabin Actions" card with Reached / Skip / Emergency buttons
/// and the floating SOS button anchored to its bottom-right corner.
class _DriverActionsCard extends StatelessWidget {
  final TripProvider trip;
  const _DriverActionsCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'DRIVER CABIN ACTIONS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                      color: CustomColor.textMutedLabel(context),
                    ),
                  ),
                  Text(
                    'Current: Stop ${trip.currentStopIndex}',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textSecondary(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ReachedStopButton(onTap: trip.markReachedStop),
              const SizedBox(height: 12),
              SkipAndEmergencyRow(
                onSkip: trip.skipStop,
                onEmergency: trip.triggerEmergency,
              ),
            ],
          ),
        ),
        Positioned(
          right: 4,
          bottom: -20,
          child: SosFloatingButton(onTap: trip.triggerEmergency),
        ),
      ],
    );
  }
}