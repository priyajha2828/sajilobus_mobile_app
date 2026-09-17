import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/passenger_provider/search_route_provider.dart';
import '../color/custom_color.dart';


/// Shared rounded-card container used across the screen.
class SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.border(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// "Koshi Province Transit Grid  ·  LIVE SYNC" status strip.
class GridStatusBar extends StatelessWidget {
  const GridStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchRouteProvider>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: CustomColor.gridStatusBg(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: CustomColor.liveGridDot,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                provider.gridLabel,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ],
          ),
          if (provider.isLiveSync)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: CustomColor.liveSyncBg(context),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bolt, size: 13, color: CustomColor.liveSyncText(context)),
                  const SizedBox(width: 4),
                  Text(
                    'LIVE SYNC',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      color: CustomColor.liveSyncText(context),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// One "From" / "To" input row used inside the Journey Planner card.
class JourneyLocationField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Color dotColor;
  final bool isFrom;
  final VoidCallback? onTrailingTap;

  const JourneyLocationField({
    super.key,
    required this.label,
    required this.controller,
    required this.dotColor,
    required this.isFrom,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: CustomColor.journeyFieldBg(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CustomColor.border(context)),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 11, color: CustomColor.textMutedLabel(context)),
                ),
                TextField(
                  controller: controller,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.textPrimary(context),
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTrailingTap,
            child: Icon(
              isFrom ? Icons.gps_fixed : Icons.close,
              size: 18,
              color: isFrom ? CustomColor.primary : CustomColor.textMutedLabel(context),
            ),
          ),
        ],
      ),
    );
  }
}

/// Full "Journey Planner" card: header, From/To fields and the swap button.
class JourneyPlannerCard extends StatelessWidget {
  const JourneyPlannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchRouteProvider>();
    final p = context.read<SearchRouteProvider>();

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.alt_route, size: 18, color: CustomColor.primary),
                  const SizedBox(width: 8),
                  Text(
                    'JOURNEY PLANNER',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: p.resetJourney,
                child: Text(
                  'Reset',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: CustomColor.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Column(
                children: [
                  JourneyLocationField(
                    label: 'From (Pickup)',
                    controller: provider.fromController,
                    dotColor: CustomColor.fromDotColor(context),
                    isFrom: true,
                    onTrailingTap: p.useCurrentLocationForPickup,
                  ),
                  const SizedBox(height: 10),
                  JourneyLocationField(
                    label: 'To (Destination)',
                    controller: provider.toController,
                    dotColor: CustomColor.toDotColor,
                    isFrom: false,
                    onTrailingTap: p.clearDestination,
                  ),
                ],
              ),
              Positioned(
                right: 6,
                top: 34,
                child: InkWell(
                  onTap: p.swapLocations,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: CustomColor.swapButtonBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.swap_vert, color: Colors.white, size: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Segmented tab bar: "All Routes (n)" / "Nearby Stops (n)" / "Active Bus...".
class TrackTabBar extends StatelessWidget {
  const TrackTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchRouteProvider>();
    final p = context.read<SearchRouteProvider>();

    Widget tab({
      required TrackTab tab,
      required IconData icon,
      required String label,
    }) {
      final selected = provider.selectedTab == tab;
      return Expanded(
        child: InkWell(
          onTap: () => p.selectTab(tab),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: selected ? CustomColor.tabSelectedBg(context) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 15, color: selected ? Colors.white : CustomColor.tabUnselectedText(context)),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : CustomColor.tabUnselectedText(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: CustomColor.tabBarBg(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          tab(tab: TrackTab.allRoutes, icon: Icons.alt_route, label: 'All Routes (${provider.allRoutesCount})'),
          tab(tab: TrackTab.nearbyStops, icon: Icons.location_on_outlined, label: 'Nearby Stops (${provider.nearbyStopsCount})'),
          tab(tab: TrackTab.activeBuses, icon: Icons.directions_bus, label: 'Active Bus...'),
        ],
      ),
    );
  }
}

/// Reusable section title row, e.g. "Direct Transit Routes" + "2 Results".
class SectionHeader extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? trailingText;
  final IconData? trailingIcon;
  final Color? trailingColor;

  const SectionHeader({
    super.key,
    this.icon,
    required this.title,
    this.trailingText,
    this.trailingIcon,
    this.trailingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: CustomColor.textPrimary(context)),
              const SizedBox(width: 6),
            ],
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
            ),
          ],
        ),
        if (trailingText != null)
          Row(
            children: [
              if (trailingIcon != null) ...[
                Icon(trailingIcon, size: 13, color: trailingColor ?? CustomColor.textMutedLabel(context)),
                const SizedBox(width: 4),
              ],
              Text(
                trailingText!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: trailingColor ?? CustomColor.textMutedLabel(context),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

/// A small pill chip, e.g. "Frequent Service", "Regional Transit".
class TagChip extends StatelessWidget {
  final String label;
  final bool isLive;

  const TagChip({super.key, required this.label, this.isLive = false});

  @override
  Widget build(BuildContext context) {
    final bg = isLive ? CustomColor.frequentServiceBg : CustomColor.regionalBadgeBg;
    final text = isLive ? CustomColor.frequentServiceText : CustomColor.regionalBadgeText(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLive) ...[
            const Icon(Icons.circle, size: 6, color: CustomColor.frequentServiceText),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: text),
          ),
        ],
      ),
    );
  }
}

/// A single live bus row/chip inside a route card ("BA 2 KHA 8492 · 3 min").
class RouteBusChip extends StatelessWidget {
  final String plate;
  final String etaLabel;
  final bool isUrgent;

  const RouteBusChip({
    super.key,
    required this.plate,
    required this.etaLabel,
    this.isUrgent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: CustomColor.busChipBg(context),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.directions_bus, size: 16, color: CustomColor.textSecondary(context)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              plate,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: CustomColor.textPrimary(context),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: CustomColor.etaBadgeBg(context, urgent: isUrgent),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              etaLabel,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: CustomColor.etaBadgeText(context, urgent: isUrgent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Full transit route card with left accent strip.
class TransitRouteCard extends StatelessWidget {
  final TransitRoute route;

  const TransitRouteCard({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    final p = context.read<SearchRouteProvider>();

    return Container(
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.border(context)),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: CustomColor.routeAccentBlue),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: CustomColor.lineBadgeBg(context),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  route.lineLabel,
                                  style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                              if (route.tagLabel != null)
                                TagChip(label: route.tagLabel!, isLive: route.tagIsLive),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  route.durationLabel,
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
                                ),
                                Text(
                                  route.durationUnit,
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CustomColor.textMutedLabel(context)),
                                ),
                                if (route.extraDurationLabel != null) ...[
                                  const SizedBox(width: 3),
                                  Text(
                                    route.extraDurationLabel!,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
                                  ),
                                  Text(
                                    route.extraDurationUnit ?? '',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CustomColor.textMutedLabel(context)),
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              route.distanceLabel,
                              style: TextStyle(fontSize: 11.5, color: CustomColor.textMutedLabel(context)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      route.title,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(width: 6, height: 6, decoration: BoxDecoration(color: CustomColor.fromDotColor(context), shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Text(route.fromStop, style: TextStyle(fontSize: 11.5, color: CustomColor.textSecondary(context))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.arrow_forward, size: 12, color: CustomColor.textMutedLabel(context)),
                        ),
                        Container(width: 6, height: 6, decoration: const BoxDecoration(color: CustomColor.toDotColor, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            route.toStop,
                            style: TextStyle(fontSize: 11.5, color: CustomColor.textSecondary(context)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.directions_bus_filled, size: 14, color: CustomColor.textSecondary(context)),
                            const SizedBox(width: 6),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: route.busCountLabel.split(' ').first + ' ',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
                                  ),
                                  TextSpan(
                                    text: route.busCountLabel.substring(route.busCountLabel.indexOf(' ') + 1),
                                    style: TextStyle(fontSize: 12, color: CustomColor.textSecondary(context)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (route.showGpsActive)
                          Text(
                            'GPS Active',
                            style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: CustomColor.gpsActiveText),
                          ),
                        if (route.nextDepartureLabel != null)
                          Text(
                            route.nextDepartureLabel!,
                            style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: CustomColor.textSecondary(context)),
                          ),
                      ],
                    ),
                    if (route.liveBuses.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      ...route.liveBuses.map((b) => RouteBusChip(plate: b.plate, etaLabel: b.etaLabel, isUrgent: b.isUrgent)),
                      if (route.moreBusesCount > 0)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '+${route.moreBusesCount} more',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CustomColor.primary),
                          ),
                        ),
                    ],
                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: route.liveBuses.isNotEmpty
                          ? ElevatedButton.icon(
                        onPressed: () => p.viewRouteSchedule(route),
                        icon: const Icon(Icons.map_outlined, size: 16),
                        label: Text(route.ctaLabel),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.ctaFilledBg(context),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                      )
                          : OutlinedButton.icon(
                        onPressed: () => p.openRouteDetails(route),
                        icon: Icon(Icons.chevron_right, size: 16, color: CustomColor.textPrimary(context)),
                        label: Text(route.ctaLabel, style: TextStyle(color: CustomColor.textPrimary(context))),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: CustomColor.ctaOutlinedBg(context),
                          side: BorderSide(color: CustomColor.border(context)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
    );
  }
}

/// A single "Nearby Bus Stop" tile.
class NearbyStopTile extends StatelessWidget {
  final NearbyBusStop stop;

  const NearbyStopTile({super.key, required this.stop});

  @override
  Widget build(BuildContext context) {
    final p = context.read<SearchRouteProvider>();
    return InkWell(
      onTap: () => p.openStop(stop),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CustomColor.card_bg(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: CustomColor.border(context)),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: CustomColor.stopIconBg(context),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.directions_bus, size: 18, color: CustomColor.stopIconColor(context)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stop.name,
                    style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.directions_walk, size: 12, color: CustomColor.textMutedLabel(context)),
                      const SizedBox(width: 4),
                      Text(
                        stop.walkOrDistanceExtra.isNotEmpty
                            ? '${stop.distanceLabel} • ${stop.walkOrDistanceExtra}'
                            : stop.distanceLabel,
                        style: TextStyle(fontSize: 11.5, color: CustomColor.textMutedLabel(context)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: CustomColor.stopEtaBg(context, soon: stop.etaSoon),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time, size: 11, color: CustomColor.stopEtaText(context, soon: stop.etaSoon)),
                      const SizedBox(width: 3),
                      Text(
                        stop.etaLabel,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: CustomColor.stopEtaText(context, soon: stop.etaSoon),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stop.routeLabel,
                  style: TextStyle(fontSize: 10.5, color: CustomColor.textMutedLabel(context)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom "Explore Live Radar" promo banner.
class LiveRadarBanner extends StatelessWidget {
  const LiveRadarBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.read<SearchRouteProvider>();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CustomColor.radarBannerBg(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(color: CustomColor.primary, shape: BoxShape.circle),
            child: const Icon(Icons.radar, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore Live Radar',
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
                ),
                Text(
                  'View all stops within 5km radius',
                  style: TextStyle(fontSize: 11.5, color: CustomColor.textSecondary(context)),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: p.openLiveRadar,
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.radarButtonBg(context),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: const Text('Open Radar', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}