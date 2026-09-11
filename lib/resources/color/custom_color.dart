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

  // Brand Colors
  static const Color primary = Color(0xFF303F9F);
  static const Color secondaryBlue = Color(0xffEAF1FF);

  static const Color green = Color(0xff4ADE80);
  static const Color greenDark = Color(0xff15803D);
  static const success = Color(0xFF16A34A);
  static const danger = Color(0xFFDC2626);
  static const warning = Color(0xFFF59E0B);



  // Background
  static Color background(BuildContext context) {
    return isDark(context)
        ? const Color(0xFF111827)
        : const Color(0xFFF5F7FB);
  }

  // Card
  static Color card(BuildContext context) {
    return isDark(context)
        ? const Color(0xFF1F2937)
        : Colors.white;
  }



  static Color textSecondary(BuildContext context) {
    return isDark(context)
        ? const Color(0xFF9CA3AF)
        : const Color(0xff6B7280);
  }

  // Border
  static Color border(BuildContext context) {
    return isDark(context)
        ? const Color(0xFF374151)
        : const Color(0xffE5E7EB);
  }
  //nav
  static Color nav(BuildContext context) {
    return isDark(context)
        ? const Color(0xFF374151)
        : const Color(0xFF303F9F);
  }
  /// Pill background for "ONLINE" / "LIVE GPS ON" status chips.
  static Color statusOnlineBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF14532D) : const Color(0xFFDCFCE7);

  static Color statusOnlineText(BuildContext context) =>
      isDark(context) ? const Color(0xFF4ADE80) : const Color(0xFF15803D);

  /// Dot used before "ONLINE" / "LIVE GPS ON".
  static const Color statusDot = Color(0xFF22C55E);

  /// "LIMIT 50" speed-limit chip.
  static Color speedLimitBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF7C2D12) : const Color(0xFFFFEDD5);

  static Color speedLimitText(BuildContext context) =>
      isDark(context) ? const Color(0xFFFDBA74) : const Color(0xFFC2410C);

  /// Blue speed progress bar fill (matches the speed card progress).
  static const Color speedProgress = Color(0xFF2563EB);
  static Color speedProgressTrack(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  /// Duration / stops-remaining info banner.
  static Color infoBannerBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFEFF6FF);

  static Color infoBannerText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : const Color(0xFF1D4ED8);

  /// Map card surface + faux-map fill.
  static Color mapSurface(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : Colors.white;

  static Color mapFill(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E293B) : const Color(0xFFDCE7F5);

  /// Floating round map-control buttons (compass / +/-).
  static Color mapControlBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : Colors.white;

  static Color mapControlIcon(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937);

  /// Active/green traffic-signal control button.
  static const Color mapControlActiveBg = Color(0xFF16A34A);

  /// "NEXT DIRECTION" banner over the map.
  static const Color nextDirectionBg = Color(0xFF1D4ED8);
  static const Color nextDirectionIconBg = Color(0xFF2563EB);

  /// Route stop timeline states.
  static const Color stopCompleted = Color(0xFF16A34A);
  static Color stopCompletedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF14532D) : const Color(0xFFDCFCE7);

  static const Color stopCurrent = Color(0xFF2563EB);
  static Color stopCurrentBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFDBEAFE);

  static Color stopUpcomingBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF3F4F6);

  static Color stopUpcomingText(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  static const Color stopFinal = Color(0xFFDC2626);

  /// "CURRENT" chip on the active stop row.
  static const Color currentChipBg = Color(0xFF2563EB);

  /// Timeline connector line.
  static Color timelineLine(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  /// Driver cabin action buttons.
  static const Color actionReachedBg = Color(0xFF16A34A);
  static Color actionSkipBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);
  static Color actionSkipText(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937);
  static const Color actionEmergencyBg = Color(0xFFDC2626);

  /// Floating SOS button.
  static const Color sosBg = Color(0xFFB91C1C);
  /// Red "3 Unread" count pill next to the "Notifications" title.
  static const Color unreadPillBg = Color(0xFFDC2626);
  static const Color unreadPillText = Colors.white;

  /// "Mark all read" pill button.
  static Color markAllReadBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFEFF6FF);
  static Color markAllReadText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : const Color(0xFF2563EB);

  /// Filter chip row ("All 8" / "Admin & Dispatch 3" / "Route Updates 2").
  static const Color filterChipSelectedBg = Color(0xFF1E293B);
  static const Color filterChipSelectedText = Colors.white;
  static const Color filterChipSelectedCountBg = Color(0xFF334155);

  static Color filterChipBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);
  static Color filterChipText(BuildContext context) =>
      isDark(context) ? const Color(0xFFE5E7EB) : const Color(0xFF374151);
  static Color filterChipCountText(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  /// Date section header ("TODAY" / "YESTERDAY") + right-side label.
  static Color sectionHeaderText(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : const Color(0xFF111827);
  static Color sectionHeaderRightText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : const Color(0xFF2563EB);
  static Color sectionHeaderArchivedText(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF9CA3AF);

  /// Notification-type leading avatar + badge chip colors.
  static const Color notifEmergencyBg = Color(0xFFDC2626);
  static Color notifEmergencyBadgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF7F1D1D) : const Color(0xFFFEE2E2);
  static Color notifEmergencyBadgeText(BuildContext context) =>
      isDark(context) ? const Color(0xFFFCA5A5) : const Color(0xFFB91C1C);

  static const Color notifRouteUpdateBg = Color(0xFF1D4ED8);
  static Color notifRouteUpdateBadgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFDBEAFE);
  static Color notifRouteUpdateBadgeText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : const Color(0xFF1D4ED8);

  static const Color notifRosterBg = Color(0xFF15803D);
  static Color notifRosterBadgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF14532D) : const Color(0xFFDCFCE7);
  static Color notifRosterBadgeText(BuildContext context) =>
      isDark(context) ? const Color(0xFF86EFAC) : const Color(0xFF15803D);

  static Color notifResolvedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);
  static Color notifResolvedBadgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF3F4F6);
  static Color notifResolvedBadgeText(BuildContext context) =>
      isDark(context) ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563);

  static const Color notifRecognitionBg = Color(0xFFCA8A04);
  static Color notifRecognitionBadgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF78350F) : const Color(0xFFFEF3C7);
  static Color notifRecognitionBadgeText(BuildContext context) =>
      isDark(context) ? const Color(0xFFFCD34D) : const Color(0xFFB45309);

  /// Small unread-status dot on top of the leading avatar circle.
  static const Color notifUnreadDot = Color(0xFF22C55E);
  static Color notifReadDot(BuildContext context) =>
      isDark(context) ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF);

  /// "Priority 1" text next to the EMERGENCY badge.
  static const Color notifPriorityText = Color(0xFFDC2626);

  /// Bottom "Alert Preferences" promo banner.
  static Color alertPrefsBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFEFF6FF);
  static Color alertPrefsIconBg(BuildContext context) => CustomColor.primary;
  static Color alertPrefsTitle(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : const Color(0xFF111827);
  static Color alertPrefsSubtitle(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

// ---- Added for Driver Profile screen ----

  // Accent blue used for links, plate number, badges, arrows
  static Color accentBlue(BuildContext context) =>
      isDark(context) ? const Color(0xFF60A5FA) : const Color(0xFF2563EB);

  static Color accentBlueBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFEFF6FF);

  // Online / active status green
  static const Color onlineGreen = Color(0xFF22C55E);

  static Color onlineGreenBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF14331F) : const Color(0xFFE9FBEF);

  // Star / rating yellow
  static const Color starYellow = Color(0xFFFBBF24);

  // Logout danger tile
  static Color dangerBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B1615) : const Color(0xFFFDECEC);

  static Color dangerBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF5C2422) : const Color(0xFFF7C9C7);

  // Warning banner (logout notice)
  static Color warningBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF3A2E12) : const Color(0xFFFFF7E6);

  // SOS floating button
  static const Color sosRed = Color(0xFFDC2626);

  // Shadow
  static Color shadow(BuildContext context) =>
      isDark(context) ? Colors.black.withOpacity(0.4) : Colors.black.withOpacity(0.06);
// Deep emergency red used for hero banner & SOS button gradient
  static const Color emergencyRedDark = Color(0xFF7F1D1D);
  static const Color emergencyRed = Color(0xFFB91C1C);
  static const Color emergencyRedLight = Color(0xFFDC2626);

  // Light red tint used behind "Instant Network Escalation" card
  static Color emergencyRedTint(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B1615) : const Color(0xFFFEF1F1);

  static Color emergencyRedTintBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF5C2422) : const Color(0xFFF8D3D1);

  // Emergency type selection tiles
  static Color typeTileBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : Colors.white;

  static Color typeTileSelectedBg(BuildContext context) => emergencyRedLight;

  static Color typeTileSelectedBorder(BuildContext context) => emergencyRedLight;

  // GNSS locked green pill
  static Color gnssLockedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF14331F) : const Color(0xFFE9FBEF);

  // Telemetry inner tiles
  static Color telemetryTileBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF111827) : const Color(0xFFF7F8FA);

  // Map placeholder gradient
  static const Color mapGradientTop = Color(0xFF64748B);
  static const Color mapGradientBottom = Color(0xFF1E293B);

  // Quick log chips
  static Color logChipBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFEFF6FF);

  static Color logChipText(BuildContext context) => accentBlue(context);

  // Dispatch preview queue badge
  static const Color queueBadgeBg = Color(0xFFFDE68A);
  static const Color queueBadgeText = Color(0xFF92400E);

  // Priority ticket card
  static Color priorityTicketBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFF9FAFB);

  // Voice channel tiles
  static Color voiceChannelIconBg(
      BuildContext context, {
        required Color base,
      }) =>
      isDark(context) ? base.withOpacity(0.18) : base.withOpacity(0.1);


// ---------------------------------------------------------------------
  // Additional tokens added for the Stop Management (FleetTrack) screen.
  // Kept in the same file/class as requested so the whole app shares one
  // theme source of truth.
  // ---------------------------------------------------------------------

  /// Dark navy header background (top "Active Route" bar area).
  static Color headerBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF0B1220) : const Color(0xFF1E2A5A);

  /// Slightly lighter navy used for header sub-elements / dividers.
  static Color headerAccentLine(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B82F6) : const Color(0xFF3B82F6);

  /// Online status green dot.
  static const Color onlineDot = Color(0xFF22C55E);

  /// Blue "CURRENT STOP" / info badge background.
  static Color badgeBlueBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A8A) : const Color(0xFFDCEAFE);

  static Color badgeBlueText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : const Color(0xFF1D4ED8);

  /// Green "LIVE GEO-FENCED" badge.
  static Color badgeGreenBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF064E3B) : const Color(0xFFDCFCE7);

  static Color badgeGreenText(BuildContext context) =>
      isDark(context) ? const Color(0xFF6EE7B7) : const Color(0xFF15803D);

  /// Amber/orange occupancy progress bar fill.
  static const Color occupancyHigh = Color(0xFFF59E0B);
  static const Color occupancyMedium = Color(0xFFFACC15);
  static const Color occupancyLow = Color(0xFF22C55E);

  static Color occupancyTrack(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  /// Stat tile backgrounds (Waiting / Boarded / Dropped).
  static Color waitingTileBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);

  static Color boardedTileBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF06281B) : const Color(0xFFE7F8EF);

  static Color droppedTileBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF111C2E) : const Color(0xFFEAF1FF);

  static Color boardedAccent(BuildContext context) => success;

  static Color droppedAccent(BuildContext context) => primary;

  /// Primary "Depart Stop" button (dark navy).
  static Color departButtonBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E293B) : const Color(0xFF1E2A5A);

  /// "Notify Waiting Passengers" button (dark green).
  static Color notifyButtonBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF064E3B) : const Color(0xFF166534);

  /// Next stop card.
  static Color nextStopCardBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);

  static Color stageBadgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  /// Timeline node colors.
  static const Color timelineCompleted = success;
  static const Color timelineActive = Color(0xFF2563EB);
  static Color timelineUpcoming(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB);
  static const Color timelineFinal = Color(0xFF4B5563);



  static Color activeNowBadgeBg(BuildContext context) => timelineActive;

  /// SOS floating button.
  static const Color sos = danger;

  /// Generic chip / tag background used for small info pills
  /// (e.g. "7 tickets pre-booked online").
  static Color chipBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF111C2E) : const Color(0xFFEAF1FF);

  static Color chipText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : primary;

  static Color iconMuted(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  // ---------------------------------------------------------------------
  // "On-color" tokens — text/icons drawn on top of a solid dark or brand
  // colored surface (header, buttons, SOS, timeline nodes, badges). These
  // stay visually the same in light/dark mode since the surface beneath
  // them doesn't change, but they're centralized here so no widget ever
  // hardcodes Colors.white / Colors.black directly.
  // ---------------------------------------------------------------------

  /// Full-opacity text/icon color for dark or brand-colored surfaces
  /// (header title, SOS label, button labels, timeline check/flag icons).
  static const Color onDark = Colors.white;

  /// Slightly muted variant for secondary header text ("Active Route",
  /// corridor subtitle line).
  static const Color onDarkMuted = Colors.white70;

  /// Faint variant for subtle overlays (avatar placeholder background).
  static const Color onDarkFaint = Colors.white24;

  /// Tint used behind icons/containers sitting on the dark header
  /// (e.g. the FleetTrack logo tile background).
  static const Color onDarkTint = Color(0x1AFFFFFF); // white @ 10%

  /// Text color placed on top of the amber/warning bus-plate badge.
  static const Color onWarning = Colors.black;
  /// Small red "KOSHI CORRIDOR DISPATCH LINK" pill above the page title.
  static Color dispatchLinkBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B0D0D) : const Color(0xFFFEE2E2);

  static Color dispatchLinkText(BuildContext context) =>
      isDark(context) ? const Color(0xFFFCA5A5) : danger;

  /// Unselected issue-category tile.
  static Color categoryTileBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFF9FAFB);

  static Color categoryTileBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  static Color categoryTileIcon(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  /// Selected issue-category tile (e.g. "Mechanical Failure").
  static Color categorySelectedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A8A) : const Color(0xFFEAF1FF);

  static Color categorySelectedBorder(BuildContext context) => primary;

  static Color categorySelectedIcon(BuildContext context) => primary;

  /// Severity segmented buttons — unselected state.
  static Color severityUnselectedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);

  static Color severityUnselectedText(BuildContext context) =>
      isDark(context) ? const Color(0xFFD1D5DB) : const Color(0xFF374151);

  /// Selected severity color per level.
  static const Color severityLow = success;
  static const Color severityMedium = warning;
  static const Color severityCritical = danger;

  /// Description text-area footer chip ("Telemetry synced").
  static Color syncedText(BuildContext context) => success;

  /// Photo attachment placeholder tile (filled thumbnail bg + dashed
  /// "Add Photo" tile border).
  static Color photoTileBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  static Color addPhotoBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB);

  static Color addPhotoIcon(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF9CA3AF);

  /// Remove ("x") button on a photo thumbnail.
  static const Color removeButtonBg = danger;

  /// High-severity warning banner above the submit button.
  static Color warningBannerBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B0D0D) : const Color(0xFFFEF2F2);

  static Color warningBannerBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF7F1D1D) : const Color(0xFFFECACA);

  static Color warningBannerIcon(BuildContext context) => danger;

  static Color warningBannerText(BuildContext context) =>
      isDark(context) ? const Color(0xFFFCA5A5) : const Color(0xFF991B1B);

  /// Incident tracking stepper.
  static const Color stepperDone = success;
  static const Color stepperActive = Color(0xFF2563EB);
  static Color stepperPending(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB);

  static Color stepperLine(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  static Color stepperLabelActive(BuildContext context) => stepperActive;

  static Color stepperLabelMuted(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  /// Ops dispatch message bubble.
  static Color dispatchMessageBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFF9FAFB);

  static Color dispatchAvatarBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

}
