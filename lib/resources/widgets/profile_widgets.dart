import 'package:flutter/material.dart';
import '../color/custom_color.dart';


/// Generic rounded card wrapper used for every section on the screen.
class SectionCard2 extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SectionCard2({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.border(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Icon-circle + title (+ optional trailing widget) used to head a section,
/// e.g. "Authentication & Security Log", "App & Travel Preferences".
class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? iconBg;
  final Color? iconColor;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.iconBg,
    this.iconColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconBg ?? CustomColor.sectionIconBg(context),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18,
            color: iconColor ?? CustomColor.sectionIconColor(context),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
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

/// A small pill/chip, e.g. "Verified Citizen ID", "ACTIVE", "Live Session".
class StatusChip extends StatelessWidget {
  final String label;
  final Color bg;
  final Color textColor;
  final IconData? icon;
  final bool showDot;

  const StatusChip({
    super.key,
    required this.label,
    required this.bg,
    required this.textColor,
    this.icon,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:2, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(color: textColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
          ],
          if (icon != null) ...[
            Icon(icon, size: 13, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Row with a leading icon + text, used for email/phone under the name.
class IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconTextRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(icon, size: 15, color: CustomColor.textSecondary(context)),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: CustomColor.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}

/// Label/value row used inside the "Authentication & Security Log" card.
class KeyValueRow extends StatelessWidget {
  final String label;
  final Widget value;

  const KeyValueRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: CustomColor.textMutedLabel(context),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Align(alignment: Alignment.centerRight, child: value),
          ),
        ],
      ),
    );
  }
}

/// Toggle row: icon + title + subtitle + Switch. Used in "App & Travel
/// Preferences" (push notifications / high contrast / audio announcements).
class ToggleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ToggleTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: CustomColor.textSecondary(context)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.tileTextPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: CustomColor.switchActive,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: CustomColor.switchTrackInactive(context),
          ),
        ],
      ),
    );
  }
}

/// Language row: icon + title + subtitle + 2-way segmented control
/// (नेपाली / English).
class LanguageToggleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitleSelected; // e.g. "Selected: English"
  final bool isEnglish;
  final ValueChanged<bool> onChanged;

  const LanguageToggleTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitleSelected,
    required this.isEnglish,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: CustomColor.textSecondary(context)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.tileTextPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitleSelected,
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: CustomColor.segmentBg(context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                _segment(context, 'नेपाली', selected: !isEnglish,
                    onTap: () => onChanged(false)),
                _segment(context, 'English', selected: isEnglish,
                    onTap: () => onChanged(true)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _segment(BuildContext context, String label,
      {required bool selected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? CustomColor.segmentSelectedBg : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected
                ? CustomColor.segmentSelectedText
                : CustomColor.segmentUnselectedText(context),
          ),
        ),
      ),
    );
  }
}

/// Tappable action row with a leading icon, title (+ optional subtitle) and
/// a trailing widget (chevron / call icon / external-link icon).
class ActionRow extends StatelessWidget {
  final IconData leadingIcon;
  final Color leadingIconBg;
  final Color leadingIconColor;
  final String title;
  final String? subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  const ActionRow({
    super.key,
    required this.leadingIcon,
    required this.leadingIconBg,
    required this.leadingIconColor,
    required this.title,
    this.subtitle,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(color: leadingIconBg, shape: BoxShape.circle),
              child: Icon(leadingIcon, size: 16, color: leadingIconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.tileTextPrimary(context),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: CustomColor.textSecondary(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

/// Thin horizontal divider matching the card's row separators.
class RowDivider extends StatelessWidget {
  const RowDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, thickness: 1, color: CustomColor.rowDivider(context));
  }
}