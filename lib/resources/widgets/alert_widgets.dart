import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/passenger_provider/alert_provider.dart';
import '../color/custom_color.dart';

/// =========================================================
/// NVTS TRANSIT — ALERTS / INBOX WIDGETS
/// =========================================================

/// Top "Live Sync Active • Koshi Transit Grid   2 New" strip.
class LiveSyncBanner extends StatelessWidget {
  const LiveSyncBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AlertsProvider>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: CustomColor.liveSyncBannerBg(context),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: CustomColor.liveSyncDot,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              provider.liveSyncActive
                  ? 'Live Sync Active • ${provider.gridLabel}'
                  : 'Live Sync Paused • ${provider.gridLabel}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: CustomColor.textPrimary(context),
              ),
            ),
          ),
          if (provider.newCount > 0) ...[
            const SizedBox(width: 10),
            Text(
              '${provider.newCount} New',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: CustomColor.accentBlue1,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// "Inbox & Alerts" title + subtitle + "Mark all read".
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                  color: CustomColor.textPrimary(context),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Real-time trip notices and safety logs',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5,
                  color: CustomColor.textSecondary(context),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: p.markAllRead,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.done_all,
                  size: 17,
                  color: CustomColor.markAllReadText(context),
                ),
                const SizedBox(width: 5),
                Text(
                  'Mark all read',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.markAllReadText(context),
                  ),
                ),
              ],
            ),
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
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? CustomColor.filterChipSelectedBg1(context)
              : CustomColor.filterChipUnselectedBg(context),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: selected
                    ? CustomColor.filterChipSelectedText1(context)
                    : CustomColor.filterChipUnselectedText(context),
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: CustomColor.filterCountBadgeBg(
                    context,
                    selected: selected,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.filterCountBadgeText(
                      context,
                      selected: selected,
                    ),
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
///
/// Uses ListView.separated with a bounded height — the chips size
/// themselves to the SizedBox height, so no IntrinsicHeight is needed
/// and nothing can overflow vertically. Right padding is 0 so the last
/// chip bleeds off the screen edge, exactly like the reference design.
class AlertFilterBar extends StatelessWidget {
  const AlertFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AlertsProvider>();
    final p = context.read<AlertsProvider>();

    final chips = <Widget>[
      AlertFilterChip(
        label: 'All',
        count: provider.totalCount,
        selected: provider.selectedFilter == AlertFilter.all,
        onTap: () => p.selectFilter(AlertFilter.all),
      ),
      AlertFilterChip(
        label: 'Bus Alerts',
        selected: provider.selectedFilter == AlertFilter.busAlerts,
        onTap: () => p.selectFilter(AlertFilter.busAlerts),
      ),
      AlertFilterChip(
        label: 'Route Updates',
        selected: provider.selectedFilter == AlertFilter.routeUpdates,
        onTap: () => p.selectFilter(AlertFilter.routeUpdates),
      ),
      AlertFilterChip(
        label: 'SOS Logs',
        selected: provider.selectedFilter == AlertFilter.sosLogs,
        onTap: () => p.selectFilter(AlertFilter.sosLogs),
      ),
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16, right: 16),
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 9),
        itemBuilder: (_, i) => chips[i],
      ),
    );
  }
}

/// "TODAY" / "YESTERDAY" section label row with trailing meta text.
class AlertSectionLabel extends StatelessWidget {
  final String dateLabel;
  final String? metaLabel;

  const AlertSectionLabel({
    super.key,
    required this.dateLabel,
    this.metaLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isArchived = metaLabel == 'Archived';

    return Row(
      children: [
        Expanded(
          child: Text(
            dateLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
              color: CustomColor.sectionDateLabel(context),
            ),
          ),
        ),
        if (metaLabel != null)
          Text(
            metaLabel!,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: isArchived
                  ? CustomColor.sectionArchivedText(context)
                  : CustomColor.sectionUnreadText(context),
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

  const _NotificationVisual({
    required this.icon,
    required this.bg,
    required this.fg,
  });
}

_NotificationVisual _visualFor(NotificationType type) {
  switch (type) {
  // Solid blue circle, white bus — the strongest avatar in the list.
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
  // Solid green circle, white shield.
    case NotificationType.sosStatus:
      return _NotificationVisual(
        icon: Icons.shield_outlined,
        bg: CustomColor.sosStatusIconBg,
        fg: CustomColor.sosStatusIconColor,
      );
    case NotificationType.schedule:
      return _NotificationVisual(
        icon: Icons.account_balance_wallet_outlined,
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
    final unread = notification.isUnread;

    return InkWell(
      onTap: () => p.openNotification(notification),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CustomColor.card_bg(context),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Header ----------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: visual.bg(context),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(visual.icon, size: 21, color: visual.fg(context)),
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: CustomColor.textPrimary(context),
                              ),
                            ),
                          ),
                          if (unread) ...[
                            const SizedBox(width: 7),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: CustomColor.unreadDot,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: CustomColor.categoryPillBg(context),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              notification.categoryLabel,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: CustomColor.categoryPillText(context),
                              ),
                            ),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            '•',
                            style: TextStyle(
                              fontSize: 12,
                              color: CustomColor.textMutedLabel(context),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              notification.categorySub,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: CustomColor.textMutedLabel(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // "Just now" is blue on unread items, muted otherwise.
                Text(
                  notification.timeLabel,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: unread ? FontWeight.bold : FontWeight.w500,
                    color: unread
                        ? CustomColor.accentBlue1
                        : CustomColor.textMutedLabel(context),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ---------- Body ----------
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.5,
                  color: CustomColor.textSecondary(context),
                ),
                children: notification.body
                    .map(
                      (seg) => TextSpan(
                    text: seg.text,
                    style: TextStyle(
                      fontWeight:
                      seg.bold ? FontWeight.bold : FontWeight.normal,
                      color: seg.bold
                          ? CustomColor.textPrimary(context)
                          : CustomColor.textSecondary(context),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),

            // ---------- Actions ----------
            if (notification.primaryActionLabel != null ||
                notification.secondaryActionLabel != null) ...[
              const SizedBox(height: 14),
              Row(
                children: [
                  if (notification.primaryActionLabel != null)
                  // Primary is wider than secondary, matching the design.
                    Expanded(
                      flex: 3,
                      child: ElevatedButton.icon(
                        onPressed: () => p.viewLiveBus(notification),
                        icon: Icon(
                          notification.primaryActionIcon ?? Icons.arrow_forward,
                          size: 17,
                        ),
                        label: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(notification.primaryActionLabel!),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          CustomColor.notifPrimaryActionBg(context),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (notification.primaryActionLabel != null &&
                      notification.secondaryActionLabel != null)
                    const SizedBox(width: 10),
                  if (notification.secondaryActionLabel != null)
                    Expanded(
                      flex: 2,
                      child: OutlinedButton.icon(
                        onPressed: () => p.playChime(notification),
                        icon: Icon(
                          notification.secondaryActionIcon ??
                              Icons.notifications,
                          size: 17,
                          color: CustomColor.textPrimary(context),
                        ),
                        label: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            notification.secondaryActionLabel!,
                            style: TextStyle(
                              color: CustomColor.textPrimary(context),
                            ),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor:
                          CustomColor.notifSecondaryActionBg(context),
                          side: BorderSide(color: CustomColor.border(context)),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
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
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CustomColor.serviceHighlightBg(context),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 76,
                height: 66,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 76,
                  height: 66,
                  color: CustomColor.border(context),
                  child: Icon(
                    Icons.directions_bus,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                      color: CustomColor.serviceHighlightLabel(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: CustomColor.textSecondary(context),
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