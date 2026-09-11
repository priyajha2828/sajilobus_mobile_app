import 'package:flutter/material.dart';
import '../color/custom_color.dart';

/// Small rounded status pill, e.g. "● ONLINE" or "● LIVE GPS ON".
class StatusPill extends StatelessWidget {
  final String label;
  final IconData? leadingIcon;

  const StatusPill({super.key, required this.label, this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: CustomColor.statusOnlineBg(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null)
            Icon(leadingIcon, size: 12, color: CustomColor.statusOnlineText(context))
          else
            Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: CustomColor.statusDot,
                shape: BoxShape.circle,
              ),
            ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: CustomColor.statusOnlineText(context),
            ),
          ),
        ],
      ),
    );
  }
}
/// Small red pill showing the unread count, e.g. "3 Unread".
class UnreadCountPill extends StatelessWidget {
  final int count;
  const UnreadCountPill({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColor.unreadPillBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$count Unread',
        style: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: CustomColor.unreadPillText,
        ),
      ),
    );
  }
}
/// Small pill badge (e.g. DRV-001)
class PillBadge extends StatelessWidget {
  final String text;
  final Color? bg;
  final Color? textColor;

  const PillBadge({super.key, required this.text, this.bg, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg ?? CustomColor.accentBlueBg(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor ?? CustomColor.accentBlue(context),
        ),
      ),
    );
  }
}