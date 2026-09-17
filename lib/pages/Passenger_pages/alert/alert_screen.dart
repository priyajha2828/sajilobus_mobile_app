import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/passenger_provider/alert_provider.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/widgets/alert_widgets.dart';

/// NVTS Transit → "Alerts" (Inbox & Alerts / Notifications) screen.
///
/// This widget renders ONLY the screen body. The top app bar
/// ("NVTS TRANSIT / Notifications" + bell + avatar) and the bottom
/// navigation bar (Home / Track / Alerts / Profile) are expected to be
/// supplied by the parent/host screen that navigates to this widget.
///
/// Wrap this widget with:
///
/// ChangeNotifierProvider(
///   create: (_) => AlertsProvider(),
///   child: const AlertsScreen(),
/// )
class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AlertsProvider>();

    // IMPORTANT: Material (not just Container) is required here because
    // AlertFilterChip, AlertNotificationCard, ServiceHighlightCard, and
    // InboxHeader all use InkWell, which needs a Material ancestor to
    // render its splash/ink effects. Without this, Flutter throws
    // "No Material widget found" for every InkWell in the tree below.
    return Material(
      color: CustomColor.bg_color(context),
      child: Column(
        children: [
          // Live sync status strip
          const LiveSyncBanner(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "Inbox & Alerts" title + "Mark all read"
                  const InboxHeader(),
                  const SizedBox(height: 16),

                  // Filter pills
                  const AlertFilterBar(),
                  const SizedBox(height: 18),

                  // Sectioned notification list
                  for (final section in provider.sections) ...[
                    AlertSectionLabel(
                      dateLabel: section.dateLabel,
                      metaLabel: section.metaLabel,
                    ),
                    const SizedBox(height: 10),
                    for (final item in section.items) ...[
                      AlertNotificationCard(notification: item),
                      // Service highlight promo shown right after the first
                      // "TODAY" notification, matching the reference screen.
                      if (section.dateLabel == 'TODAY' &&
                          item.id == 'route_diversion')
                        const ServiceHighlightCard(
                          title: 'Biratnagar Eco-Corridor',
                          subtitle:
                          '8 zero-emission electric buses added to...',
                          imageUrl:
                          'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=200&q=60',
                        ),
                    ],
                    const SizedBox(height: 4),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}