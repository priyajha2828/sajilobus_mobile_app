import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/driver_provider/notifications_provider.dart';
import '../../../providers/driver_provider/profile_provider.dart';
import '../../../resources/banner/custom_banner.dart';
import '../../../resources/bottom/driver_button.dart';
import '../../../resources/card/custom_card.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/header/custom_header.dart';
import '../../../resources/pill/driver_pill.dart';
import '../../../resources/tile/custom_tile.dart';




/// FleetTrack "Driver Notifications" screen.
///
/// NOTE: This screen only builds the page body — it does NOT include a
/// Scaffold bottomNavigationBar, since the host app supplies its own
/// bottom navigation and simply swaps this screen into its body/IndexedStack.
///
/// Wrap this in a ChangeNotifierProvider<NotificationsProvider> higher up
/// the tree, or wrap just this screen:
///
/// ChangeNotifierProvider(
///   create: (_) => NotificationsProvider(),
///   child: const NotificationsScreen(),
/// )
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      body: SafeArea(
        bottom: false,
        child: Consumer<NotificationsProvider>(
          builder: (context, notif, _) {
            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                  children: [
                    _Header(notif: notif),
                    const SizedBox(height: 16),
                    _TitleRow(notif: notif),
                    const SizedBox(height: 14),
                    _FilterRow(notif: notif),
                    const SizedBox(height: 18),
                    for (final group in notif.visibleGroups) ...[
                      SectionDateHeader(
                        label: group.label,
                        rightLabel: group.rightLabel,
                        rightLabelMuted: group.label == 'YESTERDAY',
                      ),
                      const SizedBox(height: 10),
                      for (final item in group.items) ...[
                        NotificationCard(
                          item: item,
                          onExpandToggle: () => notif.toggleExpanded(item.id),
                        ),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 6),
                    ],
                    AlertPreferencesBanner(
                      onTap: () {
                        // TODO: navigate to alert preferences settings.
                      },
                    ),
                  ],
                ),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: SosFloatingButton(onTap: notif.triggerEmergency),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Top app-style header: "FleetTrack ● ONLINE / Driver Notifications" + avatar.
class _Header extends StatelessWidget {
  final NotificationsProvider notif;
  const _Header({required this.notif});

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
                  if (notif.driverOnline)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: CustomColor.statusOnlineBg(context),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.circle, size: 7, color: CustomColor.statusDot),
                          const SizedBox(width: 5),
                          Text(
                            'ONLINE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: CustomColor.statusOnlineText(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              Text(
                'Driver Notifications',
                style: TextStyle(
                  fontSize: 12.5,
                  color: CustomColor.textSecondary(context),
                ),
              ),
            ],
          ),
        ),
        Consumer<DriverProfileProvider>(
          builder: (context, driverProfile, _) {
            final localPhotoFile = driverProfile.localPhotoFile;
            return CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFE5E7EB),
              backgroundImage: localPhotoFile != null
                  ? FileImage(localPhotoFile) as ImageProvider
                  : NetworkImage(driverProfile.profile.photoUrl),
            );
          },
        ),
      ],
    );
  }
}

/// "Notifications  3 Unread" title row + "Mark all read" button.
class _TitleRow extends StatelessWidget {
  final NotificationsProvider notif;
  const _TitleRow({required this.notif});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Notifications',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: CustomColor.textPrimary(context),
              ),
            ),
            const SizedBox(width: 8),
            UnreadCountPill(count: notif.unreadCount),
          ],
        ),
        MarkAllReadButton(onTap: notif.markAllRead),
      ],
    );
  }
}

/// Horizontally scrollable row of category filter chips.
class _FilterRow extends StatelessWidget {
  final NotificationsProvider notif;
  const _FilterRow({required this.notif});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: notif.filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final f = notif.filters[i];
          return FilterChipTile(
            label: f.label,
            count: f.count,
            selected: notif.selectedFilterKey == f.key,
            onTap: () => notif.selectFilter(f.key),
          );
        },
      ),
    );
  }
}