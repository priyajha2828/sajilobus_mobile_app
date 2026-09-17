import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/passenger_provider/alert_provider.dart';
import '../color/custom_color.dart';

/// Top "Live Sync Active • Koshi Transit Grid  ·  2 New" status strip.
class LiveSyncBanner extends StatelessWidget {
  const LiveSyncBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AlertsProvider>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: CustomColor.liveSyncBannerBg(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(color: CustomColor.liveSyncDot, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                provider.liveSyncActive
                    ? 'Live Sync Active • ${provider.gridLabel}'
                    : 'Live Sync Paused • ${provider.gridLabel}',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: CustomColor.textPrimary(context)),
              ),
            ],
          ),
          if (provider.newCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: CustomColor.newBadgeBg(context),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${provider.newCount} New',
                style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: CustomColor.newBadgeText),
              ),
            ),
        ],
      ),
    );
  }
}

/// "Inbox & Alerts" title + subtitle + "Mark all read" action.
class InboxHeader extends StatelessWidget {
  const InboxHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.read<AlertsProvider>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inbox & Alerts',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
              ),
              const SizedBox(height: 2),
              Text(
                'Real-time trip notices and safety logs',
                style: TextStyle(fontSize: 12.5, color: CustomColor.textSecondary(context)),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: p.markAllRead,
          child: Row(
            children: [
              Icon(Icons.done_all, size: 15, color: CustomColor.markAllReadText(context)),
              const SizedBox(width: 4),
              Text(
                'Mark all read',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: CustomColor.markAllReadText(context)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// One filter pill, e.g. "All 6", "Bus Alerts".
class AlertFilterChip extends StatelessWidget {
  final String label;
  final int? count;
  final bool selected;
  final VoidCallback onTap;

  const AlertFilterChip({
    super.key,
    required this.label,
    this.count,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? CustomColor.filterChipSelectedBg1(context) : CustomColor.filterChipUnselectedBg(context),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: selected ? CustomColor.filterChipSelectedText1(context) : CustomColor.filterChipUnselectedText(context),
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: CustomColor.filterCountBadgeBg(context, selected: selected),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.filterCountBadgeText(context, selected: selected),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Horizontal scrollable row of filter chips.
class AlertFilterBar extends StatelessWidget {
  const AlertFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AlertsProvider>();
    final p = context.read<AlertsProvider>();

    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          AlertFilterChip(
            label: 'All',
            count: provider.totalCount,
            selected: provider.selectedFilter == AlertFilter.all,
            onTap: () => p.selectFilter(AlertFilter.all),
          ),
          const SizedBox(width: 8),
          AlertFilterChip(
            label: 'Bus Alerts',
            selected: provider.selectedFilter == AlertFilter.busAlerts,
            onTap: () => p.selectFilter(AlertFilter.busAlerts),
          ),
          const SizedBox(width: 8),
          AlertFilterChip(
            label: 'Route Updates',
            selected: provider.selectedFilter == AlertFilter.routeUpdates,
            onTap: () => p.selectFilter(AlertFilter.routeUpdates),
          ),
          const SizedBox(width: 8),
          AlertFilterChip(
            label: 'SOS Logs',
            selected: provider.selectedFilter == AlertFilter.sosLogs,
            onTap: () => p.selectFilter(AlertFilter.sosLogs),
          ),
        ],
      ),
    );
  }
}

/// "TODAY" / "YESTERDAY" section label row with trailing meta text.
class AlertSectionLabel extends StatelessWidget {
  final String dateLabel;
  final String? metaLabel;

  const AlertSectionLabel({super.key, required this.dateLabel, this.metaLabel});

  @override
  Widget build(BuildContext context) {
    final isArchived = metaLabel == 'Archived';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          dateLabel,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: CustomColor.sectionDateLabel(context),
          ),
        ),
        if (metaLabel != null)
          Text(
            metaLabel!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isArchived ? CustomColor.sectionArchivedText(context) : CustomColor.sectionUnreadText(context),
            ),
          ),
      ],
    );
  }
}

/// Resolves icon + colors for a given [NotificationType].
class _NotificationVisual {
  final IconData icon;
  final Color Function(BuildContext) bg;
  final Color Function(BuildContext) fg;

  const _NotificationVisual({required this.icon, required this.bg, required this.fg});
}

_NotificationVisual _visualFor(NotificationType type) {
  switch (type) {
    case NotificationType.busAlert:
      return _NotificationVisual(
        icon: Icons.directions_bus,
        bg: (_) => CustomColor.busAlertIconBg,
        fg: (_) => CustomColor.busAlertIconColor,
      );
    case NotificationType.adminMessage:
      return _NotificationVisual(
        icon: Icons.warning_amber_rounded,
        bg: CustomColor.adminMessageIconBg,
        fg: CustomColor.adminMessageIconColor,
      );
    case NotificationType.sosStatus:
      return _NotificationVisual(
        icon: Icons.shield_outlined,
        bg: CustomColor.sosStatusIconBg,
        fg: CustomColor.sosStatusIconColor,
      );
    case NotificationType.schedule:
      return _NotificationVisual(
        icon: Icons.credit_card,
        bg: CustomColor.scheduleIconBg,
        fg: CustomColor.scheduleIconColor,
      );
    case NotificationType.account:
      return _NotificationVisual(
        icon: Icons.credit_card,
        bg: CustomColor.accountIconBg,
        fg: CustomColor.accountIconColor,
      );
  }
}

/// Full notification card: icon avatar, title/category/time, body, actions.
class AlertNotificationCard extends StatelessWidget {
  final AlertNotification notification;

  const AlertNotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final p = context.read<AlertsProvider>();
    final visual = _visualFor(notification.type);

    return InkWell(
      onTap: () => p.openNotification(notification),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CustomColor.card_bg(context),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: CustomColor.notificationCardBorder(context, unread: notification.isUnread)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: visual.bg(context), shape: BoxShape.circle),
                  child: Icon(visual.icon, size: 19, color: visual.fg(context)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              notification.title,
                              style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (notification.isUnread) ...[
                            const SizedBox(width: 6),
                            Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(color: CustomColor.unreadDot, shape: BoxShape.circle),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: CustomColor.categoryPillBg(context),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              notification.categoryLabel,
                              style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: CustomColor.categoryPillText(context)),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text('•', style: TextStyle(fontSize: 11, color: CustomColor.textMutedLabel(context))),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              notification.categorySub,
                              style: TextStyle(fontSize: 11.5, color: CustomColor.textMutedLabel(context)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  notification.timeLabel,
                  style: TextStyle(fontSize: 11, color: CustomColor.textMutedLabel(context)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 13, height: 1.4, color: CustomColor.textSecondary(context)),
                children: notification.body
                    .map((seg) => TextSpan(
                  text: seg.text,
                  style: TextStyle(
                    fontWeight: seg.bold ? FontWeight.bold : FontWeight.normal,
                    color: seg.bold ? CustomColor.textPrimary(context) : CustomColor.textSecondary(context),
                  ),
                ))
                    .toList(),
              ),
            ),
            if (notification.primaryActionLabel != null || notification.secondaryActionLabel != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  if (notification.primaryActionLabel != null)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => p.viewLiveBus(notification),
                        icon: Icon(notification.primaryActionIcon ?? Icons.arrow_forward, size: 15),
                        label: Text(notification.primaryActionLabel!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.notifPrimaryActionBg(context),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  if (notification.primaryActionLabel != null && notification.secondaryActionLabel != null)
                    const SizedBox(width: 10),
                  if (notification.secondaryActionLabel != null)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => p.playChime(notification),
                        icon: Icon(notification.secondaryActionIcon ?? Icons.notifications, size: 15, color: CustomColor.textPrimary(context)),
                        label: Text(notification.secondaryActionLabel!, style: TextStyle(color: CustomColor.textPrimary(context))),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: CustomColor.notifSecondaryActionBg(context),
                          side: BorderSide(color: CustomColor.border(context)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// "SERVICE HIGHLIGHT" promo card with a thumbnail image.
class ServiceHighlightCard extends StatelessWidget {
  final String label;
  final String title;
  final String subtitle;
  final String imageUrl;

  const ServiceHighlightCard({
    super.key,
    this.label = 'SERVICE HIGHLIGHT',
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.read<AlertsProvider>();
    return InkWell(
      onTap: p.openServiceHighlight,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CustomColor.serviceHighlightBg(context),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 64,
                  height: 64,
                  color: CustomColor.border(context),
                  child: Icon(Icons.directions_bus, color: CustomColor.textMutedLabel(context)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5, color: CustomColor.serviceHighlightLabel(context)),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: CustomColor.textSecondary(context)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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