import 'package:flutter/material.dart';

class CustomColor {
  CustomColor. _();

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  static Color card_bg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFFFFFFF);

  static Color bg_color(BuildContext context) =>
      isDark(context) ? const Color(0xFF111827) : const Color(0xFFF3F4F6);

  static Color logincontainer(BuildContext context) =>
      isDark(context) ? const Color(0x33000000) : const Color(0xFFFFFFFF);

  static Color tileTextPrimary(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937);

  static Color textPrimary(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937);

  static Color textMutedLabel(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

  static Color inputGlassBaseWhite(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : Colors.white;

  static Color inputBg(BuildContext context) => card_bg(context);
  static Color inputFocusBg(BuildContext context) => card_bg(context);

  static Color inputHintDefault(BuildContext context) =>
      isDark(context) ? Colors.grey.shade500 : Colors.grey.shade400;

  static Color inputBorderDefault(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB);

  static Color inputBorderError(BuildContext context) =>
      isDark(context) ? Colors.red.shade400 : Colors.red.shade800;

}