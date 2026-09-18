import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/passenger_provider/alert_provider.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/widgets/alert_widgets.dart';

/// NVTS Transit → "Alerts" (Inbox & Alerts / Notifications) screen.
///
/// Renders ONLY the screen body. The top app bar
/// ("NVTS TRANSIT / Notifications" + bell + avatar) and the bottom
/// navigation bar (Home / Track / Alerts / Profile) come from the
/// parent/host screen.
///
/// Wrap with:
///
/// ChangeNotifierProvider(
///   create: (_) => AlertsProvider(),
///   child: const AlertsScreen(),
/// )
class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  /// Horizontal page padding. Applied per-section instead of globally so
  /// the filter bar can scroll all the way to the screen edge.
  static const _pagePadding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AlertsProvider>();

    // Material (not just Container) is required: AlertFilterChip,
    // AlertNotificationCard, ServiceHighlightCard and InboxHeader all use
    // InkWell, which needs a Material ancestor for its splash.
    //
    // SafeArea(top: true) is the fix for content sitting under the status
    // bar / notch: it pads the top of this screen by exactly the system
    // inset, so the live-sync strip and title never get clipped or pushed
    // off-screen. bottom is false because the host screen's own bottom
    // navigation bar already handles the bottom inset.
    return Material(
      color: CustomColor.bg_color(context),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            const _AlertsTopBar(),
            // ---------- Live sync strip ----------
            const LiveSyncBanner(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 18, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------- Title + Mark all read ----------
                    const Padding(
                      padding: _pagePadding,
                      child: InboxHeader(),
                    ),

                    const SizedBox(height: 16),

                    // ---------- Filter pills (full-bleed) ----------
                    const AlertFilterBar(),

                    const SizedBox(height: 20),

                    // ---------- Sectioned notification list ----------
                    for (final section in provider.sections) ...[
                      Padding(
                        padding: _pagePadding,
                        child: AlertSectionLabel(
                          dateLabel: section.dateLabel,
                          metaLabel: section.metaLabel,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: _pagePadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final item in section.items) ...[
                              AlertNotificationCard(notification: item),
                              // Promo sits right after the last TODAY item,
                              // matching the reference screen.
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
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

class _AlertsTopBar extends StatelessWidget {
  const _AlertsTopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: BoxDecoration(
        color: CustomColor.transitHeaderBg(context),
        border: Border(
          bottom: BorderSide(color: CustomColor.border(context)),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications_none_rounded),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Notifications & Alerts',
              style: TextStyle(
                color: CustomColor.textPrimary(context),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const CircleAvatar(
            radius: 17,
            child: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
