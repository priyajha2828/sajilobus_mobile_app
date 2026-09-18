import 'package:flutter/material.dart';

import '../color/custom_color.dart';
import '../../providers/passenger_provider/live_track_provider.dart';

/// =========================================================
/// LIVE VEHICLE TRACKER — WIDGETS
///
/// OVERFLOW RULE used everywhere in this file:
/// any Row that holds text uses Flexible/Expanded + ellipsis,
/// so a long plate number or driver name can never push the
/// Row past its parent's width.
/// =========================================================

/// ---------------------------------------------------------
/// APP BAR
/// ---------------------------------------------------------
class LiveTrackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String avatarUrl;
  final VoidCallback? onBack;
  final VoidCallback? onAvatarTap;

  const LiveTrackAppBar({
    super.key,
    required this.title,
    required this.avatarUrl,
    this.onBack,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.card(context),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      toolbarHeight: 62,
      title: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back,
              color: CustomColor.textPrimary(context),
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: CustomColor.actionBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.directions_bus_filled,
              color: Colors.white,
              size: 19,
            ),
          ),
          const SizedBox(width: 10),
          // Flexible => long titles shrink instead of overflowing.
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CustomColor.textPrimary(context),
              ),
            ),
          ),
        ],
      ),
      actions: [
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
  Size get preferredSize => const Size.fromHeight(62);
}

/// ---------------------------------------------------------
/// MAP OVERLAY — Route pill (top-left)
/// ---------------------------------------------------------
class RouteOverlayPill extends StatelessWidget {
  final String routeNumber;
  final String from;
  final String to;

  const RouteOverlayPill({
    super.key,
    required this.routeNumber,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: CustomColor.actionBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              routeNumber,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                height: 1.15,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Flexible + ellipsis: this is the Row that used to overflow.
          Flexible(
            child: Text(
              "$from → $to",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                height: 1.2,
                color: CustomColor.textPrimary(context),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------
/// MAP OVERLAY — GPS status pill (top-right)
/// ---------------------------------------------------------
class GpsStatusPill extends StatelessWidget {
  final String text;

  const GpsStatusPill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.circle, size: 8, color: CustomColor.success),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.5,
                color: CustomColor.textPrimary(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------
/// MAP OVERLAY — small chips floating over the map
/// ---------------------------------------------------------
class MapChip extends StatelessWidget {
  final String label;
  final Color background;
  final Color textColor;
  final IconData? icon;
  final Color? iconColor;
  final bool showDot;

  const MapChip({
    super.key,
    required this.label,
    required this.background,
    required this.textColor,
    this.icon,
    this.iconColor,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.12),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            const Icon(Icons.circle, size: 7, color: CustomColor.green),
            const SizedBox(width: 6),
          ],
          if (icon != null) ...[
            Icon(icon, size: 13, color: iconColor ?? textColor),
            const SizedBox(width: 5),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bus marker with the soft halo behind it.
class BusPulseMarker extends StatelessWidget {
  const BusPulseMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74,
      height: 74,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColor.actionBlue.withOpacity(.18),
            ),
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColor.actionBlue,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: const Icon(
              Icons.directions_bus_filled,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

/// Square floating map control (recenter / layers).
class MapSquareButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const MapSquareButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColor.card(context),
      borderRadius: BorderRadius.circular(14),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, size: 21, color: CustomColor.actionBlue),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------
/// BOTTOM SHEET — grab handle
/// ---------------------------------------------------------
class SheetGrabHandle extends StatelessWidget {
  const SheetGrabHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 46,
        height: 5,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: CustomColor.border(context),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------
/// BOTTOM SHEET — vehicle header
/// ---------------------------------------------------------
class VehicleHeaderRow extends StatelessWidget {
  final String busNumber;
  final String serviceType;
  final String statusLabel;
  final String subtitle;

  const VehicleHeaderRow({
    super.key,
    required this.busNumber,
    required this.serviceType,
    required this.statusLabel,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: CustomColor.softBlue(context),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            Icons.directions_bus_filled,
            color: CustomColor.actionBlue,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Bus number takes what's left, chips keep their size.
                  Flexible(
                    child: Text(
                      busNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 88),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: CustomColor.softBlue(context),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      serviceType,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.15,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.accentBlue1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: CustomColor.success,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.circle, size: 7, color: Colors.white),
                        const SizedBox(width: 5),
                        Text(
                          statusLabel,
                          style: const TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
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
    );
  }
}

/// ---------------------------------------------------------
/// BOTTOM SHEET — metric card (2x2 grid)
/// ---------------------------------------------------------
class LiveMetricCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final String value;
  final String? valueSuffix;
  final String subtitle;
  final Color? valueColor;
  final Color? subtitleColor;
  final double? progress;

  const LiveMetricCard({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.subtitle,
    this.iconColor,
    this.valueSuffix,
    this.valueColor,
    this.subtitleColor,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CustomColor.softBlue(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .4,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Icon(icon, size: 17, color: iconColor ?? CustomColor.accentBlue1),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: valueColor ?? CustomColor.textPrimary(context),
                    ),
                  ),
                  if (valueSuffix != null)
                    TextSpan(
                      text: valueSuffix,
                      style: TextStyle(
                        fontSize: 13,
                        color: CustomColor.textSecondary(context),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.5,
              color: subtitleColor ?? CustomColor.textSecondary(context),
            ),
          ),
          if (progress != null) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress!.clamp(0.0, 1.0),
                minHeight: 6,
                backgroundColor: CustomColor.border(context),
                valueColor: AlwaysStoppedAnimation(CustomColor.accentBlue1),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Next-stop card — value is a place name, so it needs its own layout.
class NextStopCard extends StatelessWidget {
  final String stopName;
  final String status;

  const NextStopCard({
    super.key,
    required this.stopName,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CustomColor.softBlue(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "NEXT STOP",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .4,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.navigation_outlined,
                  size: 17, color: CustomColor.success),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              stopName,
              maxLines: 1,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: CustomColor.textPrimary(context),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            status,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: CustomColor.success,
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------
/// BOTTOM SHEET — route milestones
/// ---------------------------------------------------------
class RouteMilestonesCard extends StatelessWidget {
  final String title;
  final String trailing;
  final List<RouteMilestone> milestones;

  const RouteMilestonesCard({
    super.key,
    required this.title,
    required this.trailing,
    required this.milestones,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.softBlue(context),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                trailing,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.accentBlue1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < milestones.length; i++)
            MilestoneTile(
              milestone: milestones[i],
              isLast: i == milestones.length - 1,
            ),
        ],
      ),
    );
  }
}

class MilestoneTile extends StatelessWidget {
  final RouteMilestone milestone;
  final bool isLast;

  const MilestoneTile({
    super.key,
    required this.milestone,
    required this.isLast,
  });

  Color _dotColor() {
    switch (milestone.state) {
      case MilestoneState.passed:
        return const Color(0xFF9AA7BD);
      case MilestoneState.current:
        return CustomColor.actionBlue;
      case MilestoneState.scheduled:
        return const Color(0xFFB8C2D4);
      case MilestoneState.destination:
        return CustomColor.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCurrent = milestone.state == MilestoneState.current;
    final isPassed = milestone.state == MilestoneState.passed;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Rail ----
          Column(
            children: [
              Container(
                width: isCurrent ? 16 : 11,
                height: isCurrent ? 16 : 11,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent ? Colors.white : _dotColor(),
                  border: isCurrent
                      ? Border.all(color: CustomColor.actionBlue, width: 5)
                      : null,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: CustomColor.border(context),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // ---- Text ----
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          milestone.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isCurrent ? 17 : 14.5,
                            fontWeight:
                            isCurrent ? FontWeight.bold : FontWeight.w500,
                            decoration: isPassed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: isPassed
                                ? CustomColor.textSecondary(context)
                                : CustomColor.textPrimary(context),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          milestone.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight:
                            isCurrent ? FontWeight.w600 : FontWeight.normal,
                            color: isCurrent
                                ? CustomColor.accentBlue1
                                : CustomColor.textSecondary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  _trailing(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _trailing(BuildContext context) {
    if (milestone.state == MilestoneState.passed) {
      return Icon(
        Icons.check,
        size: 18,
        color: CustomColor.textSecondary(context),
      );
    }

    if (milestone.state == MilestoneState.current) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: CustomColor.softBlueStrong(context),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          milestone.trailing,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: CustomColor.accentBlue1,
          ),
        ),
      );
    }

    return Text(
      milestone.trailing,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: CustomColor.textPrimary(context),
      ),
    );
  }
}

/// ---------------------------------------------------------
/// BOTTOM SHEET — action buttons (Alert / Share / SOS)
/// ---------------------------------------------------------
class LiveActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback? onTap;

  const LiveActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        minimumSize: const Size(0, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      // FittedBox keeps "Alert"/"Share"/"SOS" inside the button on small
      // screens instead of letting the Row overflow.
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 19),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}