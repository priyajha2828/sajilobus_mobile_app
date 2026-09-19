import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sajilo_bus/config/dio_client.dart';

/// Which filter pill is currently selected under "Inbox & Alerts".
enum AlertFilter { all, busAlerts, routeUpdates, sosLogs }

/// The kind of notification, used to pick an icon + accent color.
enum NotificationType {
  busAlert,
  adminMessage,
  sosStatus,
  schedule,
  account,
}

/// One bold/non-bold text run inside a notification body.
class BodySegment {
  final String text;
  final bool bold;

  const BodySegment(this.text, {this.bold = false});
}

/// A single notification / alert entry shown in the inbox list.
class AlertNotification {
  final String id;
  final NotificationType type;
  final String title;
  final bool isUnread;
  final String categoryLabel; // "Bus Alert", "Admin Message" ...
  final String categorySub; // "Route 104", "Duhabi Sector" ...
  final String timeLabel; // "Just now", "25m ago", "4:15 PM" ...
  final List<BodySegment> body;
  final String? primaryActionLabel; // "View Live Bus"
  final IconData? primaryActionIcon;
  final String? secondaryActionLabel; // "Chime"
  final IconData? secondaryActionIcon;

  const AlertNotification({
    required this.id,
    required this.type,
    required this.title,
    this.isUnread = false,
    required this.categoryLabel,
    required this.categorySub,
    required this.timeLabel,
    required this.body,
    this.primaryActionLabel,
    this.primaryActionIcon,
    this.secondaryActionLabel,
    this.secondaryActionIcon,
  });
}

/// A dated group of notifications, e.g. "TODAY" / "YESTERDAY".
class AlertSection {
  final String dateLabel;
  final String? metaLabel; // "2 unread" / "Archived"
  final List<AlertNotification> items;

  const AlertSection({
    required this.dateLabel,
    this.metaLabel,
    required this.items,
  });
}

class AlertsProvider extends ChangeNotifier {
  Timer? _timer;
  List<AlertSection> _sections = [];

  AlertsProvider() {
    fetchNotifications();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) => fetchNotifications());
  }

  // ---------------------------------------------------------------------
  // Live sync status strip
  // ---------------------------------------------------------------------
  final bool liveSyncActive = true;
  final String gridLabel = 'Koshi Transit Grid';
  int get newCount => unreadCount;

  // ---------------------------------------------------------------------
  // Filters
  // ---------------------------------------------------------------------
  AlertFilter selectedFilter = AlertFilter.all;

  void selectFilter(AlertFilter filter) {
    selectedFilter = filter;
    notifyListeners();
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
          List<AlertNotification> items = [];
          for (var n in notifs) {
            final String title = n["title"] ?? "Notification";
            final String msg = n["message"] ?? "";
            final bool isRead = n["isRead"] == true;
            final int id = n["id"] ?? 0;
            final String dateStr = n["createdAt"] != null
                ? DateTime.tryParse(n["createdAt"].toString())?.toLocal().toString().split('.').first ?? ""
                : "";

            NotificationType type = NotificationType.busAlert;
            if (title.contains("SOS") || title.contains("EMERGENCY")) {
              type = NotificationType.sosStatus;
            } else if (title.contains("ROUTE")) {
              type = NotificationType.adminMessage;
            }

            items.add(AlertNotification(
              id: id.toString(),
              type: type,
              title: title,
              isUnread: !isRead,
              categoryLabel: type == NotificationType.sosStatus ? 'SOS Status' : 'Transit Notice',
              categorySub: 'Central Dispatch',
              timeLabel: dateStr.isNotEmpty ? dateStr : 'Recent',
              body: [BodySegment(msg)],
            ));
          }

          int unreads = items.where((i) => i.isUnread).length;
          _sections = [
            AlertSection(
              dateLabel: 'LIVE BACKEND ALERTS',
              metaLabel: '$unreads unread',
              items: items,
            ),
          ];
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Error fetching passenger notifications: $e");
    }
  }

  List<AlertSection> get sections => _sections;

  int get totalCount => _sections.fold(0, (sum, s) => sum + s.items.length);

  int get unreadCount =>
      _sections.fold(0, (sum, s) => sum + s.items.where((n) => n.isUnread).length);

  // ---------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------
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
      debugPrint("Error marking all read: $e");
    }
  }

  void viewLiveBus(AlertNotification notification) {}

  void playChime(AlertNotification notification) {}

  void openServiceHighlight() {}

  void openNotification(AlertNotification notification) {}

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}