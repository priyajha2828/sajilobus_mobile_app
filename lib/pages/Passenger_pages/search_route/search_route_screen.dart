import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/passenger_provider/search_route_provider.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/widgets/p_track_widets.dart';


/// NVTS Transit → "Track" screen (Journey Planner + Direct Transit Routes
/// + Nearby Bus Stops + Live Radar promo).
///
/// This widget renders ONLY the screen body. The top app bar
/// ("NVTS TRANSIT / Track" + bell + avatar) and the bottom navigation
/// bar (Home / Track / Alerts / Profile) are expected to be supplied by
/// the parent/host screen that navigates to this widget.
///
/// Wrap this widget with:
///
/// ChangeNotifierProvider(
///   create: (_) => TrackProvider(),
///   child: const TrackScreen(),
/// )
class P_SearchRoute extends StatelessWidget {
  const P_SearchRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchRouteProvider>();

    // NOTE: Wrapped in `Material` because this screen has no Scaffold of
    // its own (the host screen owns that). Without a Material ancestor,
    // InkWell/TextField/ElevatedButton etc. inside the child widgets throw
    // "No Material widget found".
    return Material(
      color: CustomColor.bg_color(context),
      child: Column(
        // NOTE: `stretch` (not the default `center`) so the Column gives
        // its children a bounded, full-width constraint. Without this the
        // width constraint becomes unbounded going down into
        // JourneyPlannerCard's `Row(mainAxisAlignment: spaceBetween)`,
        // which is what produced the "RenderFlex overflowed by ~99849
        // pixels" error.
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Status strip: "Koshi Province Transit Grid" + "LIVE SYNC"
          const GridStatusBar(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Journey planner
                  const JourneyPlannerCard(),
                  const SizedBox(height: 16),

                  // Segmented tabs
                  const TrackTabBar(),
                  const SizedBox(height: 20),

                  // Direct transit routes section
                  SectionHeader(
                    icon: Icons.alt_route,
                    title: 'Direct Transit Routes',
                    trailingText: '${provider.routes.length} Results',
                  ),
                  const SizedBox(height: 12),
                  for (final route in provider.routes) ...[
                    TransitRouteCard(route: route),
                    const SizedBox(height: 16),
                  ],

                  const SizedBox(height: 4),

                  // Nearby bus stops section
                  SectionHeader(
                    title: 'Nearby Bus Stops',
                    trailingIcon: Icons.gps_fixed,
                    trailingText: 'High Precision',
                    trailingColor: CustomColor.highPrecisionText(context),
                  ),
                  const SizedBox(height: 12),
                  for (final stop in provider.nearbyStops) NearbyStopTile(stop: stop),

                  const SizedBox(height: 4),

                  // Live radar promo banner
                  const LiveRadarBanner(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}