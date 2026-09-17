import 'package:flutter/material.dart';

import '../color/custom_color.dart';

/// =========================================================
/// PASSENGER — TRACK SCREEN RESOURCES
/// Every card, tile, chip and strip used by search_route_screen.dart
/// lives here. All colors come from CustomColor so light and
/// dark themes are handled automatically.
/// =========================================================

/// ---------------------------------------------------------
/// APP BAR — logo, brand + title, bell with badge, avatar
/// ---------------------------------------------------------
class TrackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String brandName;
  final String title;
  final int unreadCount;
  final String avatarUrl;
  final VoidCallback? onBellTap;
  final VoidCallback? onAvatarTap;

  const TrackAppBar({
    super.key,
    required this.brandName,
    required this.title,
    required this.unreadCount,
    required this.avatarUrl,
    this.onBellTap,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.background(context),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      toolbarHeight: 66,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: CustomColor.actionBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.directions_bus_filled,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                brandName,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .4,
                  color: CustomColor.accentBlue1,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                title,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: onBellTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.notifications_none_rounded,
                size: 26,
                color: CustomColor.textPrimary(context),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: -1,
                  top: -1,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: CustomColor.danger,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: CustomColor.background(context),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        GestureDetector(
          onTap: onAvatarTap,
          child: CircleAvatar(
            radius: 19,
            backgroundColor: CustomColor.border(context),
            backgroundImage: NetworkImage(avatarUrl),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(66);
}

/// ---------------------------------------------------------
/// SEARCH FIELD
/// ---------------------------------------------------------
class TrackSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const TrackSearchField({
    super.key,
    required this.controller,
    required this.hint,
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: CustomColor.searchBg(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: CustomColor.border(context)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 22,
            color: CustomColor.textSecondary(context),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 14.5,
                color: CustomColor.textPrimary(context),
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 14.5,
                  color: CustomColor.inputHintDefault(context),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onFilterTap,
            child: Icon(
              Icons.tune,
              size: 20,
              color: CustomColor.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------
/// FILTER CHIPS ROW
/// ---------------------------------------------------------
class TrackFilterChips extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const TrackFilterChips({
    super.key,
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final selected = index == selectedIndex;
          final isCustom = filters[index] == "Custom";

          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? CustomColor.actionBlue
                    : CustomColor.chipBg(context),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isCustom) ...[
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: selected
                          ? Colors.white
                          : CustomColor.chipText(context),
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    filters[index],
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                      color: selected
                          ? Colors.white
                          : CustomColor.chipText(context),
                    ),
                  ),
                  if (selected && !isCustom) ...[
                    const SizedBox(width: 6),
                    const Icon(Icons.check, size: 15, color: Colors.white),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ---------------------------------------------------------
/// COMMUTE SUMMARY CARD
/// ---------------------------------------------------------
class CommuteSummaryCard extends StatelessWidget {
  final String label;
  final String title;
  final String co2Text;
  final String totalTrips;
  final String totalTripsDelta;
  final String distance;
  final String distanceUnit;
  final String avgCommute;
  final String avgCommuteUnit;

  const CommuteSummaryCard({
    super.key,
    required this.label,
    required this.title,
    required this.co2Text,
    required this.totalTrips,
    required this.totalTripsDelta,
    required this.distance,
    required this.distanceUnit,
    required this.avgCommute,
    required this.avgCommuteUnit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.route_outlined,
                size: 22,
                color: CustomColor.accentBlue1,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .5,
                        color: CustomColor.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: CustomColor.successSoft(context),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.eco_outlined,
                        size: 13, color: CustomColor.success),
                    const SizedBox(width: 4),
                    Text(
                      co2Text,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: SummaryStatBox(
                  label: "Total Trips",
                  value: totalTrips,
                  suffix: totalTripsDelta,
                  suffixColor: CustomColor.success,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SummaryStatBox(
                  label: "Distance",
                  value: distance,
                  suffix: distanceUnit,
                  valueColor: CustomColor.accentBlue1,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SummaryStatBox(
                  label: "Avg Commute",
                  value: avgCommute,
                  suffix: avgCommuteUnit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Small tinted box used inside [CommuteSummaryCard].
class SummaryStatBox extends StatelessWidget {
  final String label;
  final String value;
  final String suffix;
  final Color? valueColor;
  final Color? suffixColor;

  const SummaryStatBox({
    super.key,
    required this.label,
    required this.value,
    required this.suffix,
    this.valueColor,
    this.suffixColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: CustomColor.softBlue(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.5,
              color: CustomColor.textSecondary(context),
            ),
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: valueColor ?? CustomColor.textPrimary(context),
                  ),
                ),
                TextSpan(
                  text: " $suffix",
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: suffixColor ?? CustomColor.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------
/// SECTION HEADER — "YESTERDAY • 23 OCT ———— 1 Trip Completed"
/// ---------------------------------------------------------
class TrackSectionHeader extends StatelessWidget {
  final String label;
  final String trailing;
  final Color? trailingColor;

  const TrackSectionHeader({
    super.key,
    required this.label,
    required this.trailing,
    this.trailingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: .5,
            color: CustomColor.textSecondary(context),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 1,
            color: CustomColor.divider(context),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          trailing,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: trailingColor ?? CustomColor.accentBlue1,
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------
/// FULL TRIP CARD (the expanded "Yesterday" trip)
/// ---------------------------------------------------------
class TripHistoryCard extends StatelessWidget {
  final String routeName;
  final String timeRange;
  final bool verifiedTicket;

  final String boardingStop;
  final String boardingNote;
  final String dropStop;
  final String dropNote;

  final String distance;
  final String duration;
  final String avgSpeed;

  final String busPlate;
  final String busName;
  final String fare;
  final String paymentMethod;

  final int stopCount;
  final String scheduleStatus;
  final List<String> stopsEnRoute;

  /// Drop a GoogleMap (or any widget) here; a placeholder is used when null.
  final Widget? mapWidget;

  final VoidCallback? onExpandMap;
  final VoidCallback? onViewReceipt;
  final VoidCallback? onBookAgain;

  const TripHistoryCard({
    super.key,
    required this.routeName,
    required this.timeRange,
    required this.verifiedTicket,
    required this.boardingStop,
    required this.boardingNote,
    required this.dropStop,
    required this.dropNote,
    required this.distance,
    required this.duration,
    required this.avgSpeed,
    required this.busPlate,
    required this.busName,
    required this.fare,
    required this.paymentMethod,
    required this.stopCount,
    required this.scheduleStatus,
    required this.stopsEnRoute,
    this.mapWidget,
    this.onExpandMap,
    this.onViewReceipt,
    this.onBookAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Route + verified + time ---
          Row(
            children: [
              RouteBadge(label: routeName),
              const SizedBox(width: 8),
              if (verifiedTicket) const VerifiedTicketChip(),
              const Spacer(),
              Flexible(
                child: Text(
                  timeRange,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // --- Boarding / drop timeline ---
          TripRouteTimeline(
            boardingStop: boardingStop,
            boardingNote: boardingNote,
            dropStop: dropStop,
            dropNote: dropNote,
          ),

          const SizedBox(height: 14),

          // --- Recorded map track ---
          RecordedTrackMap(
            mapWidget: mapWidget,
            onExpand: onExpandMap,
          ),

          const SizedBox(height: 14),

          // --- Distance / Duration / Avg speed ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: CustomColor.softBlue(context),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TripMetricColumn(label: "Distance", value: distance),
                ),
                Expanded(
                  child: TripMetricColumn(label: "Duration", value: duration),
                ),
                Expanded(
                  child: TripMetricColumn(
                    label: "Avg Speed",
                    value: avgSpeed,
                    valueColor: CustomColor.accentBlue1,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // --- Bus + fare row ---
          BusFareRow(
            plate: busPlate,
            busName: busName,
            fare: fare,
            paymentMethod: paymentMethod,
          ),

          const SizedBox(height: 12),

          // --- Stops en route ---
          StopsEnRouteBox(
            stopCount: stopCount,
            status: scheduleStatus,
            stops: stopsEnRoute,
          ),

          const SizedBox(height: 14),

          // --- Actions ---
          Row(
            children: [
              Expanded(
                child: SoftActionButton(
                  icon: Icons.receipt_long_outlined,
                  label: "View e-Receipt",
                  onTap: onViewReceipt,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryActionButton(
                  icon: Icons.autorenew,
                  label: "Book Again",
                  onTap: onBookAgain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Dark blue "Route 12B" pill.
class RouteBadge extends StatelessWidget {
  final String label;
  const RouteBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: CustomColor.actionBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Green dot + "Verified Ticket".
class VerifiedTicketChip extends StatelessWidget {
  const VerifiedTicketChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: CustomColor.successSoft(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.circle, size: 7, color: CustomColor.success),
          SizedBox(width: 5),
          Text(
            "Verified Ticket",
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: CustomColor.success,
            ),
          ),
        ],
      ),
    );
  }
}

/// Boarding → drop timeline with the connecting rail.
class TripRouteTimeline extends StatelessWidget {
  final String boardingStop;
  final String boardingNote;
  final String dropStop;
  final String dropNote;

  const TripRouteTimeline({
    super.key,
    required this.boardingStop,
    required this.boardingNote,
    required this.dropStop,
    required this.dropNote,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _dot(),
              Expanded(
                child: Container(
                  width: 2,
                  color: CustomColor.timelineRail(context),
                ),
              ),
              _dot(),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stop(context, boardingStop, boardingNote),
                const SizedBox(height: 12),
                _stop(context, dropStop, dropNote),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot() {
    return Container(
      width: 13,
      height: 13,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: CustomColor.actionBlue, width: 3),
        color: Colors.transparent,
      ),
    );
  }

  Widget _stop(BuildContext context, String title, String note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w600,
            color: CustomColor.textPrimary(context),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          note,
          style: TextStyle(
            fontSize: 12.5,
            color: CustomColor.textSecondary(context),
          ),
        ),
      ],
    );
  }
}

/// Rounded map thumbnail with the "GPS Recorded Track" label + expand button.
class RecordedTrackMap extends StatelessWidget {
  final Widget? mapWidget;
  final VoidCallback? onExpand;

  const RecordedTrackMap({super.key, this.mapWidget, this.onExpand});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: mapWidget ??
                  Container(
                    color: CustomColor.mapSurface(context),
                    alignment: Alignment.center,
                    child: Text(
                      "Google Map Widget Here",
                      style: TextStyle(
                        fontSize: 12,
                        color: CustomColor.textSecondary(context),
                      ),
                    ),
                  ),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: const Color(0xCC1F2937),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.navigation_outlined,
                        size: 13, color: CustomColor.green),
                    SizedBox(width: 6),
                    Text(
                      "GPS Recorded Track",
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Material(
                color: CustomColor.card(context),
                shape: const CircleBorder(),
                elevation: 2,
                child: InkWell(
                  onTap: onExpand,
                  customBorder: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.open_in_full,
                      size: 16,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Single label/value column inside the metric strip.
class TripMetricColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const TripMetricColumn({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: CustomColor.textSecondary(context),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.bold,
              color: valueColor ?? CustomColor.textPrimary(context),
            ),
          ),
        ),
      ],
    );
  }
}

/// Plate • bus name • fare row.
class BusFareRow extends StatelessWidget {
  final String plate;
  final String busName;
  final String fare;
  final String paymentMethod;

  const BusFareRow({
    super.key,
    required this.plate,
    required this.busName,
    required this.fare,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.directions_bus_outlined,
          size: 18,
          color: CustomColor.accentBlue1,
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            plate,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: CustomColor.textPrimary(context),
            ),
          ),
        ),
        Icon(Icons.circle, size: 4, color: CustomColor.textSecondary(context)),
        const SizedBox(width: 8),
        Expanded(
          flex: 4,
          child: Text(
            busName,
            style: TextStyle(
              fontSize: 13,
              color: CustomColor.textSecondary(context),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              fare,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
                color: CustomColor.success,
              ),
            ),
            Text(
              "($paymentMethod)",
              style: const TextStyle(
                fontSize: 11.5,
                color: CustomColor.success,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// "6 Stops En Route" box with the arrow chain of stop names.
class StopsEnRouteBox extends StatelessWidget {
  final int stopCount;
  final String status;
  final List<String> stops;

  const StopsEnRouteBox({
    super.key,
    required this.stopCount,
    required this.status,
    required this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CustomColor.softBlue(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, size: 17, color: CustomColor.accentBlue1),
              const SizedBox(width: 8),
              Text(
                "$stopCount Stops En Route",
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textPrimary(context),
                ),
              ),
              const Spacer(),
              Text(
                status,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            stops.join("  →  "),
            style: TextStyle(
              fontSize: 12.5,
              height: 1.5,
              color: CustomColor.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}

/// Light secondary button ("View e-Receipt").
class SoftActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const SoftActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColor.buttonSoft(context),
        foregroundColor: CustomColor.accentBlue1,
        elevation: 0,
        minimumSize: const Size(0, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      icon: Icon(icon, size: 17),
      label: Text(
        label,
        style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Filled primary button ("Book Again").
class PrimaryActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const PrimaryActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColor.actionBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size(0, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      icon: Icon(icon, size: 17),
      label: Text(
        label,
        style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// ---------------------------------------------------------
/// COMPACT TRIP TILE (Earlier this week)
/// ---------------------------------------------------------
class CompactTripTile extends StatelessWidget {
  final String routeName;
  final String dateTime;
  final String fare;
  final String from;
  final String to;
  final String distance;
  final String duration;
  final String plate;
  final VoidCallback? onTap;

  const CompactTripTile({
    super.key,
    required this.routeName,
    required this.dateTime,
    required this.fare,
    required this.from,
    required this.to,
    required this.distance,
    required this.duration,
    required this.plate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CustomColor.card(context),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: CustomColor.softBlue(context),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    routeName,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.accentBlue1,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    dateTime,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: CustomColor.textSecondary(context),
                    ),
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: CustomColor.chipBg(context),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    fare,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              from,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: CustomColor.textPrimary(context),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: CustomColor.textSecondary(context),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              to,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: CustomColor.textPrimary(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.straighten,
                              size: 13,
                              color: CustomColor.textSecondary(context)),
                          const SizedBox(width: 4),
                          Text(
                            distance,
                            style: TextStyle(
                              fontSize: 12,
                              color: CustomColor.textSecondary(context),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.circle,
                              size: 3,
                              color: CustomColor.textSecondary(context)),
                          const SizedBox(width: 8),
                          Icon(Icons.access_time,
                              size: 13,
                              color: CustomColor.textSecondary(context)),
                          const SizedBox(width: 4),
                          Text(
                            duration,
                            style: TextStyle(
                              fontSize: 12,
                              color: CustomColor.textSecondary(context),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.circle,
                              size: 3,
                              color: CustomColor.textSecondary(context)),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              plate,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: CustomColor.textSecondary(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: CustomColor.softBlue(context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: CustomColor.accentBlue1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------
/// REWARD BANNER — "Regular Rider Level 3"
/// ---------------------------------------------------------
class RiderRewardBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const RiderRewardBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CustomColor.softBlueStrong(context),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: CustomColor.actionBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events_outlined,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.4,
                      color: CustomColor.accentBlue1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.verified_outlined,
              size: 22,
              color: CustomColor.accentBlue1,
            ),
          ],
        ),
      ),
    );
  }
}