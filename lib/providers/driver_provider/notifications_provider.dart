import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sajilo_bus/config/dio_client.dart';

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
  bool isLoading = false;
  Timer? _timer;

  String selectedFilterKey = 'all';

  final List<NotificationFilter> filters = const [
    NotificationFilter(key: 'all', label: 'All', count: 8),
    NotificationFilter(key: 'admin_dispatch', label: 'Admin & Dispatch', count: 3),
    NotificationFilter(key: 'route_updates', label: 'Route Updates', count: 2),
    NotificationFilter(key: 'recognition', label: 'Recognition', count: 1),
  ];

  List<NotificationGroup> groups = [];

  NotificationsProvider() {
    fetchNotifications();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) => fetchNotifications());
  }

  Future<void> fetchNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");
      final options = (token != null && token.isNotEmpty)
          ? Options(headers: {"Authorization": "Bearer $token"})
          : null;

      final res = await DioClient.dio.get("/notifications", options: options);

      if (res.statusCode == 200 && res.data["success"] == true) {
        final List? notifs = res.data["notifications"];
        if (notifs != null) {
          List<NotificationItem> todayItems = [];
          for (var item in notifs) {
            final String title = item["title"] ?? "System Notification";
            final String message = item["message"] ?? "";
            final bool isRead = item["isRead"] == true;
            final int id = item["id"] ?? 0;
            final String dateStr = item["createdAt"] != null
                ? DateTime.tryParse(item["createdAt"].toString())?.toLocal().toString().split('.').first ?? ""
                : "";

            NotificationType type = NotificationType.routeUpdate;
            if (title.contains("SOS") || title.contains("EMERGENCY")) {
              type = NotificationType.emergency;
            } else if (title.contains("RESOLVED")) {
              type = NotificationType.resolved;
            } else if (title.contains("ROUTE")) {
              type = NotificationType.routeUpdate;
            }

            todayItems.add(NotificationItem(
              id: id.toString(),
              type: type,
              badgeLabel: type == NotificationType.emergency ? 'EMERGENCY' : 'ALERT',
              title: title,
              description: message,
              timeLabel: dateStr.isNotEmpty ? dateStr : 'Recent',
              sourceIcon: type == NotificationType.emergency ? Icons.warning_amber_rounded : Icons.info_outline,
              sourceLabel: 'Central Transit Control',
              isUnread: !isRead,
            ));
          }

          groups = [
            NotificationGroup(
              label: 'LIVE BACKEND NOTIFICATIONS',
              rightLabel: 'Koshi Transit Corridor',
              items: todayItems,
            ),
          ];
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Error fetching driver notifications: $e");
    }
  }

  int get unreadCount =>
      groups.fold(0, (sum, g) => sum + g.items.where((n) => n.isUnread).length);

  /// Currently visible groups after applying [selectedFilterKey].
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

  Future<void> markAllRead() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");
      final options = (token != null && token.isNotEmpty)
          ? Options(headers: {"Authorization": "Bearer $token"})
          : null;

      await DioClient.dio.patch("/notifications/read-all", options: options);
      fetchNotifications();
    } catch (e) {
      debugPrint("Error marking notifications read: $e");
    }
  }

  void triggerEmergency() {
    debugPrint('EMERGENCY / SOS triggered from Notifications screen');
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}