import 'package:flutter/material.dart';

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

/// One bold/non-bold text run inside a notification body, so the UI can
/// render mixed-weight text (e.g. "Bus **BA 2 KHA 8492** is approaching
/// **Bargachhi Stop**.") without parsing markdown at render time.
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
  AlertsProvider();

  // ---------------------------------------------------------------------
  // Live sync status strip
  // ---------------------------------------------------------------------
  final bool liveSyncActive = true;
  final String gridLabel = 'Koshi Transit Grid';
  final int newCount = 2;

  // ---------------------------------------------------------------------
  // Filters
  // ---------------------------------------------------------------------
  AlertFilter selectedFilter = AlertFilter.all;

  void selectFilter(AlertFilter filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  // ---------------------------------------------------------------------
  // Data: sectioned notifications
  // ---------------------------------------------------------------------
  final List<AlertSection> _sections = [
    AlertSection(
      dateLabel: 'TODAY',
      metaLabel: '2 unread',
      items: [
        AlertNotification(
          id: 'bus_arrival',
          type: NotificationType.busAlert,
          title: 'Bus Arrival in 3 Mins',
          isUnread: true,
          categoryLabel: 'Bus Alert',
          categorySub: 'Route 104',
          timeLabel: 'Just now',
          body: const [
            BodySegment('Bus '),
            BodySegment('BA 2 KHA 8492', bold: true),
            BodySegment(' is approaching '),
            BodySegment('Bargachhi Stop', bold: true),
            BodySegment('. Prepare to board via front door.'),
          ],
          primaryActionLabel: 'View Live Bus',
          primaryActionIcon: Icons.near_me,
          secondaryActionLabel: 'Chime',
          secondaryActionIcon: Icons.volume_up_outlined,
        ),
        AlertNotification(
          id: 'route_diversion',
          type: NotificationType.adminMessage,
          title: 'Route Diversion Notice',
          isUnread: true,
          categoryLabel: 'Admin Message',
          categorySub: 'Duhabi Sector',
          timeLabel: '25m ago',
          body: const [
            BodySegment('Road maintenance near '),
            BodySegment('Duhabi Bridge', bold: true),
            BodySegment('. Expect 5–8 minutes delay for routes transiting northbound.'),
          ],
        ),
      ],
    ),
    AlertSection(
      dateLabel: 'YESTERDAY',
      metaLabel: 'Archived',
      items: [
        AlertNotification(
          id: 'sos_resolved',
          type: NotificationType.sosStatus,
          title: 'SOS Test Resolved',
          categoryLabel: 'SOS Status',
          categorySub: 'Drill Log #418',
          timeLabel: '4:15 PM',
          body: const [
            BodySegment('Your emergency drill alert was safely resolved and archived by the central transport dispatch unit.'),
          ],
        ),
        AlertNotification(
          id: 'fare_revision',
          type: NotificationType.schedule,
          title: 'Fare Schedule Revision',
          categoryLabel: 'Schedule',
          categorySub: 'Tariffs',
          timeLabel: '10:00 AM',
          body: const [
            BodySegment('Koshi Province revised student discount fares are now active. Tap card at tap-in terminals to apply automatic 33% concession.'),
          ],
        ),
        AlertNotification(
          id: 'pass_renewal',
          type: NotificationType.account,
          title: 'Monthly Pass Renewal',
          categoryLabel: 'Account',
          categorySub: 'SmartCard',
          timeLabel: '08:12 AM',
          body: const [
            BodySegment('Your 30-day unlimited commuter pass will expire in 4 days. Auto-recharge is enabled via connectIPS.'),
          ],
        ),
      ],
    ),
  ];

  List<AlertSection> get sections => _sections;

  int get totalCount => _sections.fold(0, (sum, s) => sum + s.items.length);

  int get unreadCount =>
      _sections.fold(0, (sum, s) => sum + s.items.where((n) => n.isUnread).length);

  // ---------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------
  void markAllRead() {
    for (var s = 0; s < _sections.length; s++) {
      final section = _sections[s];
      final updatedItems = section.items
          .map((n) => AlertNotification(
        id: n.id,
        type: n.type,
        title: n.title,
        isUnread: false,
        categoryLabel: n.categoryLabel,
        categorySub: n.categorySub,
        timeLabel: n.timeLabel,
        body: n.body,
        primaryActionLabel: n.primaryActionLabel,
        primaryActionIcon: n.primaryActionIcon,
        secondaryActionLabel: n.secondaryActionLabel,
        secondaryActionIcon: n.secondaryActionIcon,
      ))
          .toList();
      _sections[s] = AlertSection(
        dateLabel: section.dateLabel,
        metaLabel: section.metaLabel == 'Archived' ? section.metaLabel : '0 unread',
        items: updatedItems,
      );
    }
    notifyListeners();
  }

  void viewLiveBus(AlertNotification notification) {
    // TODO: navigate to live bus tracking screen
  }

  void playChime(AlertNotification notification) {
    // TODO: play notification chime sound
  }

  void openServiceHighlight() {
    // TODO: navigate to service highlight / eco-corridor detail screen
  }

  void openNotification(AlertNotification notification) {
    // TODO: navigate to a notification detail screen
  }
}