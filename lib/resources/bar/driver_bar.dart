import 'package:flutter/material.dart';
import '../card/driver_card.dart';
import '../color/custom_color.dart';


/// Occupancy progress bar with label + percentage.
class OccupancyBar extends StatelessWidget {
  final int current;
  final int max;
  final double percent;
  final int percentInt;

  const OccupancyBar({
    super.key,
    required this.current,
    required this.max,
    required this.percent,
    required this.percentInt,
  });

  Color _fillColor() {
    if (percent >= 0.85) return CustomColor.occupancyHigh;
    if (percent >= 0.6) return CustomColor.occupancyMedium;
    return CustomColor.occupancyLow;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard1(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups_outlined,
                  size: 18, color: CustomColor.iconMuted(context)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Occupancy Real-Time',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ),
              Text(
                '$current / $max  ($percentInt%)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: percent.clamp(0, 1),
              minHeight: 8,
              backgroundColor: CustomColor.occupancyTrack(context),
              valueColor: AlwaysStoppedAnimation<Color>(_fillColor()),
            ),
          ),
        ],
      ),
    );
  }
}