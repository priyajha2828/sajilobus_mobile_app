import 'package:flutter/material.dart';
import '../color/custom_color.dart';

// ---- private shared helpers ----

class IconChip extends StatelessWidget {
  final IconData icon;
  const IconChip({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        color: CustomColor.accentBlueBg(context),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 18, color: CustomColor.accentBlue(context)),
    );
  }
}

class TitleSubtitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleSubtitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: CustomColor.textPrimary(context),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12.5, color: CustomColor.textSecondary(context)),
        ),
      ],
    );
  }
}
class LogTagChip extends StatelessWidget {
  final String label;
  const LogTagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: CustomColor.logChipBg(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: CustomColor.logChipText(context),
        ),
      ),
    );
  }
}
class TagChip extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;

  const TagChip({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
/// One tab in the horizontal date-range filter row.
class FilterTabChip extends StatelessWidget {
  final String label;
  final bool selected;
  final IconData? icon;
  final VoidCallback onTap;

  const FilterTabChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? CustomColor.filterTabSelectedBg(context)
        : CustomColor.filterTabUnselectedBg(context);
    final fg = selected
        ? CustomColor.filterTabSelectedText(context)
        : CustomColor.filterTabUnselectedText(context);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: selected
              ? null
              : Border.all(color: CustomColor.border(context)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected)
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(Icons.check, size: 14, color: fg),
              ),
            if (!selected && icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(icon, size: 14, color: fg),
              ),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/// Small bordered pill, e.g. "TRP-2025-1042".
class OutlineChip extends StatelessWidget {
  final String label;

  const OutlineChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColor.outlineChipBg(context),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: CustomColor.outlineChipBorder(context)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: CustomColor.outlineChipText(context),
        ),
      ),
    );
  }
}


/// A quick-destination pill chip shown under the search bar
/// (e.g. "Itahari Chowk").
class DestinationChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const DestinationChip({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: CustomColor.destinationChipBg(context),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: CustomColor.destinationChipText(context)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: CustomColor.destinationChipText(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

