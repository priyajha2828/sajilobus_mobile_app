import 'package:flutter/material.dart';
import '../../providers/passenger_provider/live_track_provider.dart';
import '../color/custom_color.dart';


/// ============================================================================
/// passenger_sos — shared resources (cards / tiles / badges / map pieces)
/// ============================================================================

/// Small pill: "Route 104  Biratnagar → Itahari"
class RoutePill extends StatelessWidget {
  final String routeNumber;
  final String from;
  final String to;

  const RoutePill({
    super.key,
    required this.routeNumber,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: CustomColor.routePillBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Route',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(routeNumber,
                  style: TextStyle(
                      color: CustomColor.textPrimary(context),
                      fontWeight: FontWeight.w700,
                      fontSize: 13)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(from,
                      style: TextStyle(
                          color: CustomColor.textPrimary(context),
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward,
                      size: 12, color: CustomColor.textSecondary(context)),
                  const SizedBox(width: 4),
                  Text(to,
                      style: TextStyle(
                          color: CustomColor.textPrimary(context),
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Small pill: "● GPS 100% • 5s ago"
class GpsStatusBadge extends StatelessWidget {
  final double signalPercent;
  final int updatedSecondsAgo;

  const GpsStatusBadge({
    super.key,
    required this.signalPercent,
    required this.updatedSecondsAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: CustomColor.gpsActiveDot,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'GPS ${signalPercent.toInt()}% • ${updatedSecondsAgo}s ago',
            style: TextStyle(
              color: CustomColor.textPrimary(context),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

/// Paints the dashed diagonal route line on the map.
class DashedRoutePainter extends CustomPainter {
  final Color color;
  const DashedRoutePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.16, size.height * 0.98)
      ..quadraticBezierTo(
        size.width * 0.30,
        size.height * 0.62,
        size.width * 0.40,
        size.height * 0.52,
      )
      ..quadraticBezierTo(
        size.width * 0.55,
        size.height * 0.40,
        size.width * 0.62,
        size.height * 0.22,
      )
      ..lineTo(size.width * 0.92, size.height * 0.02);

    const dashWidth = 10.0;
    const dashSpace = 8.0;
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant DashedRoutePainter oldDelegate) =>
      oldDelegate.color != color;
}

/// The stylized map panel: background, dashed route, stop markers, live bus
/// marker, "You are here" tooltip, and floating locate/layers controls.
class LiveMapPanel extends StatelessWidget {
  final String nextStopLabel;
  final String vehiclePlate;
  final VoidCallback onLocatePressed;
  final VoidCallback onLayersPressed;
  final double height;

  const LiveMapPanel({
    super.key,
    required this.nextStopLabel,
    required this.vehiclePlate,
    required this.onLocatePressed,
    required this.onLayersPressed,
    this.height = 480,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          // Map background
          Container(color: CustomColor.mapBackground(context)),

          // Dashed route line
          Positioned.fill(
            child: CustomPaint(
              painter: DashedRoutePainter(color: CustomColor.routeLine(context)),
            ),
          ),

          // Route end marker (top right)
          const Positioned(
            top: 12,
            right: 26,
            child: _EndpointDot(color: CustomColor.primary),
          ),

          // Passed waypoint marker
          Positioned(
            top: height * 0.44,
            right: 46,
            child: _EndpointDot(color: CustomColor.primary),
          ),

          // Vehicle plate chip
          Positioned(
            top: height * 0.48,
            left: 18,
            child: _PlateChip(plate: vehiclePlate),
          ),

          // Next stop label chip
          Positioned(
            top: height * 0.40,
            left: 130,
            child: _InfoChip(
              icon: Icons.location_on,
              label: nextStopLabel,
            ),
          ),

          // Live bus marker + "You are here" tooltip
          Positioned(
            top: height * 0.52,
            left: size(context).width * 0.28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BusMarker(),
              ],
            ),
          ),
          Positioned(
            top: height * 0.58,
            left: size(context).width * 0.40,
            child: const _HereTooltip(),
          ),

          // Lower waypoint (unvisited)
          Positioned(
            top: height * 0.78,
            left: 108,
            child: _EndpointDot(
              color: CustomColor.textMutedLabel(context),
              filled: false,
            ),
          ),

          // Floating map controls
          Positioned(
            right: 16,
            bottom: 16,
            child: Column(
              children: [
                _MapControlButton(
                  icon: Icons.my_location,
                  onTap: onLocatePressed,
                ),
                const SizedBox(height: 12),
                _MapControlButton(
                  icon: Icons.layers_outlined,
                  onTap: onLayersPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Size size(BuildContext context) => MediaQuery.of(context).size;
}

class _EndpointDot extends StatelessWidget {
  final Color color;
  final bool filled;
  const _EndpointDot({required this.color, this.filled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? Colors.white : Colors.white,
        border: Border.all(color: color, width: 3),
      ),
    );
  }
}

class _PlateChip extends StatelessWidget {
  final String plate;
  const _PlateChip({required this.plate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.circle, size: 8, color: CustomColor.gpsActiveDot),
          const SizedBox(width: 6),
          Text(
            plate,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: CustomColor.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: CustomColor.primary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _BusMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColor.busMarkerRing(context),
      ),
      child: Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColor.busMarkerFill,
        ),
        child: const Icon(Icons.directions_bus, color: Colors.white, size: 18),
      ),
    );
  }
}

class _HereTooltip extends StatelessWidget {
  const _HereTooltip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: CustomColor.hereTooltipBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on, size: 14, color: Colors.white),
          SizedBox(width: 4),
          Text(
            'You are here',
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _MapControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _MapControlButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColor.mapControlBg(context),
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: CustomColor.textPrimary(context), size: 20),
        ),
      ),
    );
  }
}

/// Drag handle shown at the top of the bottom sheet content.
class SheetDragHandle extends StatelessWidget {
  const SheetDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: CustomColor.border(context),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

/// Vehicle summary card: bus icon, plate, tag, ACTIVE badge, plate/driver line.
class VehicleInfoCard extends StatelessWidget {
  final String vehiclePlate;
  final String fullPlateNumber;
  final String driverName;
  final String serviceTag;
  final bool isActive;

  const VehicleInfoCard({
    super.key,
    required this.vehiclePlate,
    required this.fullPlateNumber,
    required this.driverName,
    required this.serviceTag,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: CustomColor.secondaryBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.directions_bus, color: CustomColor.primary),
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
                      vehiclePlate,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _Tag(text: serviceTag),
                  const SizedBox(width: 8),
                  _ActiveBadge(isActive: isActive),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Plate: $fullPlateNumber • Driver: $driverName',
                style: TextStyle(
                  fontSize: 12,
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

class _Tag extends StatelessWidget {
  final String text;
  const _Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColor.tagBg(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: CustomColor.tagText(context),
        ),
      ),
    );
  }
}

class _ActiveBadge extends StatelessWidget {
  final bool isActive;
  const _ActiveBadge({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColor.activeBadgeBg(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: CustomColor.success,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            isActive ? 'ACTIVE' : 'INACTIVE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: CustomColor.activeBadgeText(context),
            ),
          ),
        ],
      ),
    );
  }
}

/// Generic 2x2 grid stat card: "ARRIVAL IN / 3 mins / Live ETA to pickup".
class StatCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget valueWidget;
  final String? footer;
  final Color? footerColor;

  /// Optional extra content rendered below the value/footer,
  /// e.g. a [CrowdProgressBar].
  final Widget? trailingContent;

  const StatCard({
    super.key,
    required this.label,
    required this.icon,
    required this.valueWidget,
    this.footer,
    this.footerColor,
    this.trailingContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.border(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                  color: CustomColor.textMutedLabel(context),
                ),
              ),
              Icon(icon, size: 16, color: CustomColor.textMutedLabel(context)),
            ],
          ),
          const SizedBox(height: 8),
          valueWidget,
          if (footer != null) ...[
            const SizedBox(height: 4),
            Text(
              footer!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: footerColor ?? CustomColor.textSecondary(context),
              ),
            ),
          ],
          if (trailingContent != null) ...[
            const SizedBox(height: 8),
            trailingContent!,
          ],
        ],
      ),
    );
  }
}

/// Crowd progress bar used inside the CROWD stat card.
class CrowdProgressBar extends StatelessWidget {
  final double ratio;
  const CrowdProgressBar({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: LinearProgressIndicator(
        value: ratio.clamp(0, 1),
        minHeight: 6,
        backgroundColor: CustomColor.progressTrack(context),
        valueColor: const AlwaysStoppedAnimation<Color>(CustomColor.progressFill),
      ),
    );
  }
}

/// One row inside the Route Milestones card.
class MilestoneTile extends StatelessWidget {
  final RouteMilestone milestone;
  final bool isLast;

  const MilestoneTile({
    super.key,
    required this.milestone,
    this.isLast = false,
  });

  Color _dotColor(BuildContext context) {
    switch (milestone.status) {
      case MilestoneStatus.passed:
        return CustomColor.milestonePassed(context);
      case MilestoneStatus.current:
        return CustomColor.milestoneCurrent;
      case MilestoneStatus.scheduled:
        return CustomColor.milestoneUpcoming(context);
      case MilestoneStatus.destination:
        return CustomColor.milestoneDestination;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPassed = milestone.status == MilestoneStatus.passed;
    final isCurrent = milestone.status == MilestoneStatus.current;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: isCurrent ? 14 : 10,
                height: isCurrent ? 14 : 10,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent ? Colors.white : _dotColor(context),
                  border: isCurrent
                      ? Border.all(color: CustomColor.milestoneCurrent, width: 3)
                      : null,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    color: CustomColor.border(context),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          milestone.title,
                          style: TextStyle(
                            fontSize: isCurrent ? 15 : 13,
                            fontWeight:
                            isCurrent ? FontWeight.w700 : FontWeight.w600,
                            color: isPassed
                                ? CustomColor.textMutedLabel(context)
                                : CustomColor.textPrimary(context),
                            decoration: isPassed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          milestone.subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isCurrent
                                ? CustomColor.success
                                : CustomColor.textMutedLabel(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isPassed)
                    Icon(Icons.check,
                        size: 18, color: CustomColor.textMutedLabel(context)),
                  if (isCurrent)
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: CustomColor.nowBadgeBg(context),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'NOW',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: CustomColor.nowBadgeText(context),
                        ),
                      ),
                    ),
                  if (milestone.etaMinutesLabel != null)
                    Text(
                      milestone.etaMinutesLabel!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.textMutedLabel(context),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom bar action button (Alert / Share / SOS).
class BottomActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  const BottomActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: foreground),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}