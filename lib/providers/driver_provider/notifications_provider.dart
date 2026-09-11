import 'package:flutter/material.dart';

/// The category a notification belongs to — drives its leading icon,
/// avatar color and badge chip color.
enum NotificationType {
  emergency,
  routeUpdate,
  rosterAssigned,
  resolved,
  recognition,
}

class NotificationItem {
  final String id;
  final NotificationType type;
  final String badgeLabel; // "EMERGENCY", "ROUTE UPDATE", ...
  final String? priorityLabel; // "Priority 1" (emergency only)
  final String title;
  final String description;
  final String timeLabel; // "10m ago", "Yesterday, 4:30 PM"
  final IconData sourceIcon;
  final String sourceLabel; // "Dispatch Control • Itahari Base"
  final bool isUnread;
  bool isExpanded;

  NotificationItem({
    required this.id,
    required this.type,
    required this.badgeLabel,
    this.priorityLabel,
    required this.title,
    required this.description,
    required this.timeLabel,
    required this.sourceIcon,
    required this.sourceLabel,
    this.isUnread = false,
    this.isExpanded = false,
  });
}

/// A date-grouped section of the notifications list, e.g. "TODAY" with
/// a contextual right-aligned label ("Koshi Transit Corridor"), or
/// "YESTERDAY" with an "Archived" label.
class NotificationGroup {
  final String label;
  final String rightLabel;
  final List<NotificationItem> items;

  NotificationGroup({
    required this.label,
    required this.rightLabel,
    required this.items,
  });
}

/// One of the horizontally-scrollable filter chips at the top of the list
/// ("All 8", "Admin & Dispatch 3", "Route Updates 2", ...).
class NotificationFilter {
  final String key;
  final String label;
  final int count;

  const NotificationFilter({
    required this.key,
    required this.label,
    required this.count,
  });
}

/// Holds all state for the "Driver Notifications" screen: the grouped
/// notification feed, the active filter tab, and the actions the driver
/// can take (mark all read, expand a card, trigger SOS).
class NotificationsProvider extends ChangeNotifier {
  // Header
  bool driverOnline = true;

  String selectedFilterKey = 'all';

  final List<NotificationFilter> filters = const [
    NotificationFilter(key: 'all', label: 'All', count: 8),
    NotificationFilter(key: 'admin_dispatch', label: 'Admin & Dispatch', count: 3),
    NotificationFilter(key: 'route_updates', label: 'Route Updates', count: 2),
    NotificationFilter(key: 'recognition', label: 'Recognition', count: 1),
  ];

  final List<NotificationGroup> groups = [
    NotificationGroup(
      label: 'TODAY',
      rightLabel: 'Koshi Transit Corridor',
      items: [
        NotificationItem(
          id: 'n1',
          type: NotificationType.emergency,
          badgeLabel: 'EMERGENCY',
          priorityLabel: 'Priority 1',
          title: 'Fog Alert & Speed Limit Reduction',
          description:
          'Koshi Highway between Itahari and Tarahara reports dense morning fog. Maintain reduced speed and increase following distance.',
          timeLabel: '10m ago',
          sourceIcon: Icons.cloud_outlined,
          sourceLabel: 'Dispatch Control • Itahari Base',
          isUnread: true,
        ),
        NotificationItem(
          id: 'n2',
          type: NotificationType.routeUpdate,
          badgeLabel: 'ROUTE UPDATE',
          title: 'Traffic Diversion at Duhabi Bridge',
          description:
          'Single lane open due to bridge maintenance. Follow traffic warden instructions when approaching the crossing.',
          timeLabel: '45m ago',
          sourceIcon: Icons.shield_outlined,
          sourceLabel: 'Koshi Traffic Dept',
          isUnread: true,
        ),
        NotificationItem(
          id: 'n3',
          type: NotificationType.rosterAssigned,
          badgeLabel: 'ROSTER ASSIGNED',
          title: "Tomorrow's Shift Schedule Confirmed",
          description:
          'Assigned to Bus BA 2 KHA 4567, Biratnagar to Kakarbhitta Route. Report by 6:00 AM at the depot.',
          timeLabel: '2h ago',
          sourceIcon: Icons.badge_outlined,
          sourceLabel: 'Fleet Manager Ramesh K.',
          isUnread: true,
        ),
      ],
    ),
    NotificationGroup(
      label: 'YESTERDAY',
      rightLabel: 'Archived',
      items: [
        NotificationItem(
          id: 'n4',
          type: NotificationType.resolved,
          badgeLabel: 'RESOLVED',
          title: 'Report #REP-8930 Resolved',
          description:
          'Bus AC compressor inspection completed by maintenance team. Cleared for long-distance service.',
          timeLabel: 'Yesterday, 4:30 PM',
          sourceIcon: Icons.build_outlined,
          sourceLabel: 'Biratnagar Central Depot',
          isUnread: false,
        ),
        NotificationItem(
          id: 'n5',
          type: NotificationType.recognition,
          badgeLabel: 'RECOGNITION',
          title: 'High Rating Badge Earned',
          description:
          'Congratulations! You maintained a 98% on-time departure score for October.',
          timeLabel: 'Yesterday, 10:00 AM',
          sourceIcon: Icons.emoji_events_outlined,
          sourceLabel: 'Operations Directorate',
          isUnread: false,
        ),
      ],
    ),
  ];

  int get unreadCount =>
      groups.fold(0, (sum, g) => sum + g.items.where((n) => n.isUnread).length);

  /// Currently visible groups after applying [selectedFilterKey].
  /// (Simple demo mapping — wire this to your real category data.)
  List<NotificationGroup> get visibleGroups {
    if (selectedFilterKey == 'all') return groups;

    bool matches(NotificationItem n) {
      switch (selectedFilterKey) {
        case 'admin_dispatch':
          return n.type == NotificationType.emergency ||
              n.type == NotificationType.rosterAssigned ||
              n.type == NotificationType.resolved;
        case 'route_updates':
          return n.type == NotificationType.routeUpdate;
        case 'recognition':
          return n.type == NotificationType.recognition;
        default:
          return true;
      }
    }

    return groups
        .map((g) => NotificationGroup(
      label: g.label,
      rightLabel: g.rightLabel,
      items: g.items.where(matches).toList(),
    ))
        .where((g) => g.items.isNotEmpty)
        .toList();
  }

  void selectFilter(String key) {
    selectedFilterKey = key;
    notifyListeners();
  }

  void toggleExpanded(String id) {
    for (final g in groups) {
      for (final n in g.items) {
        if (n.id == id) {
          n.isExpanded = !n.isExpanded;
          notifyListeners();
          return;
        }
      }
    }
  }

  void markAllRead() {
    for (final g in groups) {
      for (var i = 0; i < g.items.length; i++) {
        final n = g.items[i];
        if (n.isUnread) {
          g.items[i] = NotificationItem(
            id: n.id,
            type: n.type,
            badgeLabel: n.badgeLabel,
            priorityLabel: n.priorityLabel,
            title: n.title,
            description: n.description,
            timeLabel: n.timeLabel,
            sourceIcon: n.sourceIcon,
            sourceLabel: n.sourceLabel,
            isUnread: false,
            isExpanded: n.isExpanded,
          );
        }
      }
    }
    notifyListeners();
  }

  void triggerEmergency() {
    // TODO: wire this to your actual emergency/SOS backend call.
    debugPrint('EMERGENCY / SOS triggered from Notifications screen');
    notifyListeners();
  }
}