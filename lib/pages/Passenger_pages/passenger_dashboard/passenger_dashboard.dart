import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/passenger_provider/dashboard_provider.dart';
import '../../../resources/bar/custom_bar.dart';
import '../../../resources/card/custom_card.dart';
import '../../../resources/chip/custom_chip.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/header/custom_header.dart';
import '../../../resources/tile/custom_tile.dart';



/// NVTS Transit passenger app — Home screen.
///
/// NOTE: This screen intentionally does NOT include a bottomNavigationBar —
/// it is expected to be pushed/shown inside your own navigation shell
/// (the one with Home / Track / Alerts / Profile).
class TransitHomeScreen extends StatelessWidget {
  const TransitHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransitHomeProvider(),
      child: const _TransitHomeBody(),
    );
  }
}

class _TransitHomeBody extends StatelessWidget {
  const _TransitHomeBody();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransitHomeProvider>();
    final p = context.read<TransitHomeProvider>();

    return Scaffold(
      backgroundColor: CustomColor.background(context),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _TopBar(provider: provider)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GreetingHeader(
                      userName: provider.userName,
                      isGpsSynced: provider.isGpsSynced,
                      dateLabel: provider.dateLabel,
                      locationLabel: provider.locationLabel,
                    ),
                    const SizedBox(height: 16),
                    HomeSearchBar(
                      controller: provider.searchController,
                      hint: 'Where are you going today?',
                      onChanged: p.updateSearch,
                      onMicTap: p.startVoiceSearch,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 34,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.quickDestinations.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final d = provider.quickDestinations[index];
                          return DestinationChip(
                            icon: d.icon,
                            label: d.label,
                            onTap: () => p.selectDestination(d.label),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    RoutePromoCard(
                      data: provider.routePromo,
                      onQuickTrack: p.quickTrackRoute,
                    ),
                    const SizedBox(height: 22),
                    SectionHeader1(
                      title: 'Quick Transit Hub',
                      trailingText: 'FAST ACCESS',
                    ),
                    const SizedBox(height: 12),
                    _QuickActionsGrid(provider: provider),
                    const SizedBox(height: 22),
                    SectionHeader1(
                      title: 'Live Highway Radar',
                      trailingText: 'Expand Map',
                      trailingIcon: Icons.open_in_new,
                      trailingColor: CustomColor.primary,
                      onTrailingTap: p.expandMap,
                    ),
                    const SizedBox(height: 12),
                    LiveRadarCard(
                      activeLabel: provider.radarActiveLabel,
                      highwayLabel: provider.radarHighwayLabel,
                      speedLabel: provider.radarSpeedLabel,
                      onRecenter: p.recenterRadar,
                    ),
                    const SizedBox(height: 22),
                    _NearbyBusesHeader(provider: provider),
                    const SizedBox(height: 12),
                    for (final bus in provider.nearbyBuses) ...[
                      LiveBusCard(
                        bus: bus,
                        isBookmarked:
                        provider.bookmarkedBuses.contains(bus.plateNumber),
                        onTrack: () => p.trackBus(bus.plateNumber),
                        onBookmarkToggle: () =>
                            p.toggleBookmark(bus.plateNumber),
                      ),
                      const SizedBox(height: 14),
                    ],
                  ],
                ),
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
  final TransitHomeProvider provider;
  const _TopBar({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: BoxDecoration(

        color: CustomColor.transitHeaderBg(context),
        border: Border(bottom: BorderSide(color: CustomColor.border(context))),
      ),
      child: Row(
        children: [
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.appName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color: CustomColor.primary,
                  ),
                ),
                Text(
                  provider.pageLabel,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              InkWell(
                onTap: () =>
                    context.read<TransitHomeProvider>().openNotifications(),
                child: Icon(Icons.notifications_none_rounded,
                    size: 24, color: CustomColor.textPrimary(context)),
              ),
              if (provider.notificationCount > 0)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: CustomColor.countBadgeBg,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
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
// Quick Transit Hub grid
// ---------------------------------------------------------------------
class _QuickActionsGrid extends StatelessWidget {
  final TransitHomeProvider provider;
  const _QuickActionsGrid({required this.provider});

  @override
  Widget build(BuildContext context) {
    final p = context.read<TransitHomeProvider>();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.quickActions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.05,
      ),
      itemBuilder: (context, index) {
        final action = provider.quickActions[index];
        return QuickActionTile(
          icon: action.icon,
          label: action.label,
          isHighlighted: action.isHighlighted,
          badgeCount: action.badgeCount,
          onTap: () => p.openQuickAction(action.label),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------
// "Nearby Real-time Buses" header (title + subtitle + count badge)
// ---------------------------------------------------------------------
class _NearbyBusesHeader extends StatelessWidget {
  final TransitHomeProvider provider;
  const _NearbyBusesHeader({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nearby Real-time Buses',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: CustomColor.textPrimary(context),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                provider.nearbySubtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: CustomColor.textSecondary(context),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: CustomColor.chipBg(context),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${provider.nearbyBuses.length} Found',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: CustomColor.chipText(context),
            ),
          ),
        ),
      ],
    );
  }
}