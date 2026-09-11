import 'package:flutter/material.dart';

import '../color/custom_color.dart';

/// Section label like "1. SELECT EMERGENCY TYPE" with trailing helper text
class NumberedSectionLabel extends StatelessWidget {
  final String title;
  final String? trailing;

  const NumberedSectionLabel({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color: CustomColor.textSecondary(context),
          ),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: CustomColor.accentBlue(context),
            ),
          ),
      ],
    );
  }
}

IconData iconFromKey(String key) {
  switch (key) {
    case 'directions_bus':
      return Icons.directions_bus_filled_outlined;
    case 'car_crash':
      return Icons.car_crash_outlined;
    case 'medical_services':
      return Icons.medical_services_outlined;
    case 'shield':
      return Icons.shield_outlined;
    case 'headset':
      return Icons.headset_mic_rounded;
    case 'medical':
      return Icons.local_hospital_rounded;
    default:
      return Icons.circle;
  }
}
