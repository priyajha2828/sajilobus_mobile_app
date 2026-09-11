import 'package:flutter/material.dart';
import '../color/custom_color.dart';

/// Section header used above each date group of notifications, e.g.
/// "TODAY" — "Koshi Transit Corridor" or "YESTERDAY" — "Archived".
class SectionDateHeader extends StatelessWidget {
  final String label;
  final String rightLabel;

  /// Give the right-hand label a muted/archived style instead of the
  /// default accent-blue style (used for "Archived").
  final bool rightLabelMuted;

  const SectionDateHeader({
    super.key,
    required this.label,
    required this.rightLabel,
    this.rightLabelMuted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
            color: CustomColor.sectionHeaderText(context),
          ),
        ),
        Text(
          rightLabel,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: rightLabelMuted
                ? CustomColor.sectionHeaderArchivedText(context)
                : CustomColor.sectionHeaderRightText(context),
          ),
        ),
      ],
    );
  }
}
/// Section header: icon + title + optional trailing badge
class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: CustomColor.accentBlue(context)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: CustomColor.textPrimary(context),
            ),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
/// "LIVE TELEMETRY SNAPSHOT" header row with GNSS Locked pill
class TelemetryHeader extends StatelessWidget {
  const TelemetryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.satellite_alt_outlined,
                size: 16, color: CustomColor.textSecondary(context)),
            const SizedBox(width: 6),
            Text(
              'LIVE TELEMETRY SNAPSHOT',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
                color: CustomColor.textSecondary(context),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: CustomColor.gnssLockedBg(context),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.circle, size: 6, color: CustomColor.success),
              const SizedBox(width: 4),
              Text(
                'GNSS Locked',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.success,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

