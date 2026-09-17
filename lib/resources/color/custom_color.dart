import 'package:flutter/material.dart';

class CustomColor {
  CustomColor._();

  static bool isDark(BuildContext context) =>
      Theme
          .of(context)
          .brightness == Brightness.dark;

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
      isDark(context) ? Colors.black.withOpacity(0.4) : Colors.black
          .withOpacity(0.06);

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

  static Color typeTileSelectedBorder(BuildContext context) =>
      emergencyRedLight;

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
  static Color voiceChannelIconBg(BuildContext context, {
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


  // ---------------------------------------------------------------------
  // Trip Manifest Detail screen tokens
  // ---------------------------------------------------------------------

  /// Search bar.
  static Color searchBarBg(BuildContext context) => card(context);

  static Color searchBarBorder(BuildContext context) => border(context);

  static Color searchIconColor(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF9CA3AF);

  /// Filter tabs (Today / This Week / This Month / Custom).
  static Color filterTabSelectedBg(BuildContext context) => primary;

  static Color filterTabUnselectedBg(BuildContext context) => card(context);

  static Color filterTabSelectedText(BuildContext context) => onDark;

  static Color filterTabUnselectedText(BuildContext context) =>
      textSecondary(context);

  /// Backgrounds for the four 2x2 summary stat tiles' icon circles.
  static Color statIconBg(BuildContext context, Color accent) =>
      isDark(context) ? accent.withOpacity(0.18) : accent.withOpacity(0.12);

  static const Color statBlue = Color(0xFF2563EB);
  static const Color statGreen = success;
  static const Color statPurple = Color(0xFF7C3AED);
  static const Color statTeal = Color(0xFF0D9488);

  /// Small bordered pill used for Trip ID tags (e.g. "TRP-2025-1042").
  static Color outlineChipBg(BuildContext context) => card(context);

  static Color outlineChipBorder(BuildContext context) => border(context);

  static Color outlineChipText(BuildContext context) =>
      textSecondary(context);

  /// Origin / destination route timeline dots.
  static const Color originDot = Color(0xFF2563EB);
  static const Color destinationDot = success;

  static Color timelineConnector(BuildContext context) => border(context);

  /// Map / GPS telemetry preview card.
  static const Color mapBgStart = Color(0xFFD9EAD3);
  static const Color mapBgEnd = Color(0xFFC3DFC0);

  static const Color mapOverlayBadgeBg = Color(0xB3111827); // ~70% black
  static const Color mapOverlayText = onDark;

  static const Color mapVerifiedDot = Color(0xFF22C55E);

  static const Color mapPlaceholderIcon = Color(0x42000000); // black @ 26%

  /// Department of Transport compliance banner.
  static Color departmentBannerBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFEAF1FF);

  static Color departmentBannerIcon(BuildContext context) => primary;

  static Color departmentBannerTitle(BuildContext context) =>
      textPrimary(context);

  static Color departmentBannerSubtitle(BuildContext context) =>
      textSecondary(context);

  /// Share / icon-only square button.
  static Color squareButtonBg(BuildContext context) => card(context);

  static Color squareButtonBorder(BuildContext context) => border(context);


  /// Top app bar (white/light header for the passenger app, unlike the
  /// driver app's dark navy header).
  static Color transitHeaderBg(BuildContext context) => card(context);

  static Color locationLinkColor(BuildContext context) => primary;

  /// Quick-destination pill chips under the search bar.
  static Color destinationChipBg(BuildContext context) => chipBg(context);

  static Color destinationChipText(BuildContext context) => chipText(context);

  /// "ROUTE #104 / Daily Commute" promo card gradient.
  static const Color routeCardGradientStart = Color(0xFF1E2A5A);
  static const Color routeCardGradientEnd = Color(0xFF2A3B7A);

  /// Translucent white pill badges on top of the dark promo card
  /// (e.g. "ROUTE #104", "NPR 45").
  static const Color routeCardBadgeBg = onDarkTint;
  static const Color routeCardBadgeText = onDark;

  /// Quick Track button on the dark promo card (white fill, brand text).
  static const Color routeQuickTrackBg = onDark;
  static const Color routeQuickTrackText = primary;

  /// Progress search_route/fill for the route's live position bar (drawn on the
  /// dark promo card).
  static const Color routeProgressTrack = onDarkFaint;
  static const Color routeProgressFill = onDark;

  /// Quick Transit Hub grid tiles — normal tile reuses [categoryTileBg] /
  /// [categoryTileBorder] / [categoryTileIcon]. The SOS Panic tile gets
  /// its own high-alert styling:
  static const Color sosTileBg = Color(0xFF7F1D1D);
  static const Color sosTileText = onDark;

  /// Small red numeric badge (e.g. the "2" on Alerts / bell icon).
  static const Color countBadgeBg = danger;
  static const Color countBadgeText = onDark;

  /// Live Highway Radar map placeholder.
  static const Color radarBgStart = Color(0xFF374151);
  static const Color radarBgEnd = Color(0xFF1F2937);

  static const Color radarOverlayBg = mapOverlayBadgeBg;
  static const Color radarOverlayText = onDark;
  static const Color radarActiveDot = mapVerifiedDot;

  /// Live bus card status badges.
  static Color statusActiveBg(BuildContext context) => badgeGreenBg(context);

  static Color statusActiveText(BuildContext context) =>
      badgeGreenText(context);

  static Color statusMaintenanceBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFE5E7EB);

  static Color statusMaintenanceText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : const Color(0xFF4B5563);

  /// ETA text color: blue when approaching, muted gray when delayed.
  static const Color etaActiveColor = Color(0xFF2563EB);

  static Color etaDelayedColor(BuildContext context) =>
      textMutedLabel(context);

  /// Seat-capacity progress bar fill levels.
  static const Color capacityFewSeats = warning;
  static const Color capacitySpacious = success;
  static const Color capacityFull = danger;

  static Color capacityTrack(BuildContext context) => occupancyTrack(context);

  /// "Track Live Bus" button — full brand color for the nearest/urgent
  /// bus, a muted variant for less urgent ones.
  static Color trackButtonMutedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A8A) : const Color(0xFFDCEAFE);

  static Color trackButtonMutedText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : primary;

  /// Maintenance / inspection warning row inside a bus card.
  static Color warningRowBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B2F0D) : const Color(0xFFFFFBEB);

  static Color warningRowText(BuildContext context) =>
      isDark(context) ? const Color(0xFFFCD34D) : const Color(0xFF92400E);

  static const Color warningRowIcon = warning;

  // ----------------------------------------------------------------------
  // Emergency SOS screen specific colors (added, theme-aware where relevant)
  // ----------------------------------------------------------------------

  /// Gradient start for the top "Emergency Transit" alert banner.
  static Color emergencyBannerStart(BuildContext context) =>
      isDark(context) ? const Color(0xFFB91C1C) : const Color(0xFFEF4444);

  /// Gradient end for the top "Emergency Transit" alert banner.
  static Color emergencyBannerEnd(BuildContext context) =>
      isDark(context) ? const Color(0xFF7F1D1D) : const Color(0xFFDC2626);

  /// "LIVE LINE" pill background on the banner.
  static Color liveLinePill(BuildContext context) =>
      isDark(context) ? Colors.white.withOpacity(0.18) : Colors.white
          .withOpacity(0.22);

  /// Blinking live-status dot.
  static const Color liveDot = Color(0xFF4ADE80);

  /// Accuracy / telemetry lock badge background.
  static Color accuracyBadgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF14532D) : const Color(0xFFDCFCE7);

  static Color accuracyBadgeText(BuildContext context) =>
      isDark(context) ? const Color(0xFF4ADE80) : const Color(0xFF15803D);

  /// GPS coordinates info card background.
  static Color gpsCardBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E293B) : const Color(0xFFF0F4FF);

  /// Vehicle chip badge (BA 2 KHA...).
  static Color vehicleChipBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A8A) : const Color(0xFF1D4ED8);

  static Color speedChipBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF14532D) : const Color(0xFFDCFCE7);

  static Color speedChipText(BuildContext context) =>
      isDark(context) ? const Color(0xFF4ADE80) : const Color(0xFF15803D);

  /// Dispatch lifecycle stepper colors.
  static Color stepActive(BuildContext context) => primary;

  static Color stepInactive(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  static Color stepLineActive(BuildContext context) => primary;

  static Color stepLineInactive(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  /// Emergency type selectable cards.
  static Color emergencyTypeCardBg(BuildContext context,
      {required bool selected, required Color accent}) {
    if (selected) {
      return isDark(context) ? accent.withOpacity(0.22) : accent.withOpacity(
          0.10);
    }
    return card_bg(context);
  }

  static Color emergencyTypeCardBorder(BuildContext context,
      {required bool selected, required Color accent}) {
    if (selected) return accent;
    return border(context);
  }

  static const Color medicalAccent = Color(0xFF2563EB);
  static const Color harassmentAccent = Color(0xFFDC2626);
  static const Color collisionAccent = Color(0xFFF59E0B);
  static const Color rashDrivingAccent = Color(0xFF7C3AED);

  /// SOS button gradient.
  static Color sosOuterGlow(BuildContext context) =>
      isDark(context) ? const Color(0x33DC2626) : const Color(0x22DC2626);

  static const Color sosButtonStart = Color(0xFFEF4444);
  static const Color sosButtonEnd = Color(0xFFB91C1C);

  /// Call action buttons.
  static Color callPoliceBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A8A) : const Color(0xFF1D4ED8);

  static Color callTrafficBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF134E4A) : const Color(0xFF0D9488);

  /// Dispatch preview "MONITORED 24/7" badge.
  static Color monitoredBadgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF14532D) : const Color(0xFF16A34A);

  static const Color monitoredBadgeText = Colors.white;

  // ----------------------------------------------------------------------
  // Track screen specific colors (added, theme-aware where relevant)
  // ----------------------------------------------------------------------

  /// "Koshi Province Transit Grid" status strip background.
  static Color gridStatusBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E293B) : const Color(0xFFEAF1FF);

  /// "LIVE SYNC" pill.
  static Color liveSyncBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF14532D) : const Color(0xFFDCFCE7);

  static Color liveSyncText(BuildContext context) =>
      isDark(context) ? const Color(0xFF4ADE80) : const Color(0xFF15803D);

  static const Color liveGridDot = Color(0xFF16A34A);

  /// Journey planner card "From"/"To" field container.
  static Color journeyFieldBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF111827) : const Color(0xFFF7F8FA);

  static Color fromDotColor(BuildContext context) => primary;
  static const Color toDotColor = Color(0xFFDC2626);

  /// Swap-locations circular button.
  static const Color swapButtonBg = primary;

  /// Segmented tab bar ("All Routes" / "Nearby Stops" / "Active Bus...").
  static Color tabBarBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);

  static Color tabSelectedBg(BuildContext context) => primary;

  static Color tabUnselectedText(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

  /// Route card left accent strip + line badge.
  static const Color routeAccentBlue = primary;

  static Color lineBadgeBg(BuildContext context) => primary;
  static const Color frequentServiceBg = Color(0xFFDCFCE7);
  static const Color frequentServiceText = Color(0xFF15803D);
  static const Color regionalBadgeBg = Color(0xFFEAF1FF);

  static Color regionalBadgeText(BuildContext context) => primary;

  /// GPS active label.
  static const Color gpsActiveText = Color(0xFF16A34A);

  /// Individual live-bus chip inside a route card.
  static Color busChipBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF111827) : const Color(0xFFF7F8FA);

  static Color etaBadgeBg(BuildContext context, {required bool urgent}) {
    if (urgent) {
      return isDark(context) ? const Color(0xFF14532D) : const Color(
          0xFF16A34A);
    }
    return isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);
  }

  static Color etaBadgeText(BuildContext context, {required bool urgent}) {
    if (urgent) return Colors.white;
    return textPrimary(context);
  }

  /// Primary CTA buttons ("View Route Schedule & Map", "Route Details").
  static Color ctaFilledBg(BuildContext context) => primary;

  static Color ctaOutlinedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF111827) : const Color(0xFFF7F8FA);

  /// Nearby bus stop tiles.
  static Color stopIconBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A8A) : const Color(0xFFEAF1FF);

  static Color stopIconColor(BuildContext context) => primary;

  static Color stopEtaBg(BuildContext context, {required bool soon}) {
    if (soon) {
      return isDark(context) ? const Color(0xFF14532D) : const Color(
          0xFFDCFCE7);
    }
    return isDark(context) ? const Color(0xFF374151) : const Color(0xFFF3F4F6);
  }

  static Color stopEtaText(BuildContext context, {required bool soon}) {
    if (soon) return isDark(context) ? const Color(0xFF4ADE80) : const Color(
        0xFF15803D);
    return textSecondary(context);
  }

  /// "High Precision" pill next to Nearby Bus Stops header.
  static Color highPrecisionText(BuildContext context) => primary;

  /// "Explore Live Radar" bottom banner.
  static Color radarBannerBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E293B) : const Color(0xFFEAF1FF);

  static Color radarButtonBg(BuildContext context) => primary;

// ----------------------------------------------------------------------
// Alerts / Notifications screen specific colors (added, theme-aware)
// ----------------------------------------------------------------------

  /// Top "Live Sync Active • Koshi Transit Grid" strip.
  static Color liveSyncBannerBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E293B) : const Color(0xFFEAF1FF);

  static const Color liveSyncDot = Color(0xFF16A34A);

  /// "2 New" pill on the live sync banner.
  static Color newBadgeBg(BuildContext context) => primary;
  static const Color newBadgeText = Colors.white;

  /// Filter chips ("All", "Bus Alerts", "Route Updates", "SOS Logs").
  static Color filterChipSelectedBg1(BuildContext context) => primary;
  static Color filterChipUnselectedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);

  static Color filterChipSelectedText1(BuildContext context) => Colors.white;
  static Color filterChipUnselectedText(BuildContext context) =>
      isDark(context) ? const Color(0xFFD1D5DB) : const Color(0xFF374151);


  /// "All" chip unread-count badge.
  static Color filterCountBadgeBg(BuildContext context,
      {required bool selected}) =>
      selected ? Colors.white.withOpacity(0.25) : (isDark(context)
          ? const Color(0xFF374151)
          : const Color(0xFFE5E7EB));

  static Color filterCountBadgeText(BuildContext context,
      {required bool selected}) =>
      selected ? Colors.white : textPrimary(context);

  /// "TODAY" / "YESTERDAY" section labels + trailing meta text.
  static Color sectionDateLabel(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  static Color sectionUnreadText(BuildContext context) => primary;

  static Color sectionArchivedText(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  /// Per-notification-type icon avatar backgrounds / icon colors.
  static const Color busAlertIconBg = primary;
  static const Color busAlertIconColor = Colors.white;

  static Color adminMessageIconBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF78350F) : const Color(0xFFFEF3C7);

  static Color adminMessageIconColor(BuildContext context) =>
      isDark(context) ? const Color(0xFFFBBF24) : const Color(0xFFB45309);

  static Color sosStatusIconBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF14532D) : const Color(0xFFDCFCE7);

  static Color sosStatusIconColor(BuildContext context) =>
      isDark(context) ? const Color(0xFF4ADE80) : const Color(0xFF15803D);

  static Color scheduleIconBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF312E81) : const Color(0xFFEAE7FD);

  static Color scheduleIconColor(BuildContext context) =>
      isDark(context) ? const Color(0xFFC4B5FD) : const Color(0xFF6D28D9);

  static Color accountIconBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF134E4A) : const Color(0xFFCCFBF1);

  static Color accountIconColor(BuildContext context) =>
      isDark(context) ? const Color(0xFF5EEAD4) : const Color(0xFF0F766E);

  /// Category pill (e.g. "Bus Alert", "Admin Message") per notification.
  static Color categoryPillBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF3F4F6);

  static Color categoryPillText(BuildContext context) => textSecondary(context);

  /// Unread blue dot next to a notification title.
  static const Color unreadDot = primary;

  /// Notification card border when unread vs read.
  static Color notificationCardBorder(BuildContext context,
      {required bool unread}) {
    if (unread) return isDark(context) ? const Color(0xFF1E3A8A) : const Color(
        0xFFC7D2FE);
    return border(context);
  }

  /// Primary action button ("View Live Bus").
  static Color notifPrimaryActionBg(BuildContext context) => primary;

  /// Secondary/outlined action button ("Chime").
  static Color notifSecondaryActionBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF111827) : const Color(0xFFF7F8FA);

  /// Service highlight promo card.
  static Color serviceHighlightBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E293B) : const Color(0xFFEAF1FF);

  static Color serviceHighlightLabel(BuildContext context) => primary;

// ---------------------------------------------------------------------
  // Passenger SOS (Live Vehicle Tracker) screen tokens
  // ---------------------------------------------------------------------

  /// Top red "Emergency Transit SOS" banner.
  static Color emergencyBannerBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF7F1D1D) : danger;

  static const Color emergencyBannerText = onDark;
  static const Color emergencyBannerIconBg = onDarkTint;

  /// "LIVE LINE" pill + its blinking dot, sitting on the red banner.
  static const Color liveLineBadgeBg = Color(0x33000000); // black @ 20%
  static const Color liveLineBadgeText = onDark;
  static const Color liveLineDot = Color(0xFF4ADE80);

  /// Telemetry-lock status row.
  static Color telemetryIcon(BuildContext context) => primary;

  /// GPS coordinates card (light blue tint).
  static Color gpsCardBg1(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : secondaryBlue;

  static Color gpsCardIcon(BuildContext context) => primary;

  /// Vehicle search_route row badges.
  static Color vehicleBadgeBg(BuildContext context) => chipBg(context);
  static Color vehicleBadgeText(BuildContext context) => chipText(context);

  static Color speedBadgeBg(BuildContext context) => badgeGreenBg(context);
  static Color speedBadgeText(BuildContext context) => badgeGreenText(context);

  /// "Nature of Emergency" tile — unselected reuses [categoryTileBg] /
  /// [categoryTileBorder] / [categoryTileIcon]. Selected (e.g. "Harassment")
  /// gets a red highlight:
  static Color emergencySelectedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B0D0D) : const Color(0xFFFEF2F2);

  static Color emergencySelectedBorder(BuildContext context) => danger;

  static Color emergencySelectedIcon(BuildContext context) => danger;

  /// Incident-details voice/text field reuses [inputBg] / [inputBorderDefault].
  static Color voiceButtonBg(BuildContext context) => chipBg(context);

  static Color voiceButtonIcon(BuildContext context) => primary;

  /// Critical Response Initiator panel background + big SOS button.
  static Color criticalPanelBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF2A1015) : const Color(0xFFFDECEC);

  static const Color criticalPanelAccentBlob = Color(0x1ADC2626); // danger @ 10%

  static const Color sosButtonGradientStart = Color(0xFFDC2626);
  static const Color sosButtonGradientEnd = Color(0xFF991B1B);

  static const Color sosButtonRing = Color(0x33FFFFFF); // white @ 20%
  static const Color sosProgressRing = onDark;
  static const Color sosButtonText = onDark;

  static Color criticalLabelColor(BuildContext context) => danger;

  static Color criticalDescriptionText(BuildContext context) =>
      textSecondary(context);

  /// Emergency call buttons (Call 100 / Call 103).
  static Color callPoliceBg1(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B0D0D) : const Color(0xFFFEF2F2);

  static Color callPoliceIcon(BuildContext context) => danger;

  static Color callTrafficBg1(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : secondaryBlue;

  static Color callTrafficIcon(BuildContext context) => primary;

  /// Central Transit Dispatch Preview card.
  static Color monitoredBadgeBg1(BuildContext context) => success;

  static const Color monitoredBadgeText1 = onDark;

  static Color dispatchLinkValue(BuildContext context) => primary;

  static Color dispatchRowLabel(BuildContext context) => textMutedLabel(context);

  static Color dispatchRowValue(BuildContext context) => textPrimary(context);

  static Color channelLockIcon(BuildContext context) => iconMuted(context);

  /// Footer "Return to Navigation Safely" link.
  static Color footerLinkColor(BuildContext context) => textSecondary(context);
  // ---------------------------------------------------------------------
  // Additions below — needed specifically for the Profile screen.
  // Kept in the same file/style so the whole app keeps one color source.
  // ---------------------------------------------------------------------

  /// AppBar background (white on light, surface-dark on dark).
  static Color appBarBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : Colors.white;

  /// Small red dot on the notification bell.
  static const Color notificationDot = Color(0xFFEF4444);

  /// Circular icon-button background (bell / avatar wrapper) on the AppBar.
  static Color iconCircleBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF3F4F6);

  /// "Verified Citizen ID" chip.
  static Color verifiedBg(BuildContext context) =>
      isDark(context) ? const Color(0x2616A34A) : const Color(0xFFE9F9EF);
  static const Color verifiedText = success;

  /// Edit pencil badge on the profile avatar.
  static const Color editBadgeBg = primary;

  /// Transit card gradient (dark navy → indigo, matches screenshot).
  static const List<Color> transitCardGradient = [
    Color(0xFF16213E),
    Color(0xFF23306E),
  ];
  static const Color transitCardActiveBg = Color(0x33FFFFFF);
  static const Color transitCardActiveText = Colors.white;
  static const Color transitCardMuted = Color(0xFFB9C0DE);

  /// Emergency SOS circular icon background / text.
  static const Color sosIcon = danger;

  /// "Live Session" chip.
  static Color liveSessionBg(BuildContext context) =>
      isDark(context) ? const Color(0x2616A34A) : const Color(0xFFE9F9EF);
  static const Color liveSessionDot = success;
  static const Color liveSessionText = success;

  /// Auth UID pill background.
  static Color pillBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF3F4F6);

  /// Section header icon circle background (preferences / help desk / auth).
  static Color sectionIconBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFEFF1F8);
  static Color sectionIconColor(BuildContext context) =>
      isDark(context) ? Colors.white70 : primary;

  /// Switch colors.
  static const Color switchActive = Color(0xFF22C55E);
  static Color switchTrackInactive(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB);

  /// Language segmented toggle.
  static Color segmentBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF3F4F6);
  static const Color segmentSelectedBg = primary;
  static const Color segmentSelectedText = Colors.white;
  static Color segmentUnselectedText(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  /// Logout button.
  static Color logoutBg(BuildContext context) =>
      isDark(context) ? const Color(0x26DC2626) : const Color(0xFFFDEBEB);
  static const Color logoutText = danger;

  /// Divider between rows inside a card.
  static Color rowDivider(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF0F1F5);

  // ---------------------------------------------------------------------
  // Additions below — needed specifically for the Passenger SOS /
  // "Trusted Safety Circle" screen.
  // ---------------------------------------------------------------------

  /// "Trusted Safety Circle" info banner.
  static Color sosBannerBg(BuildContext context) =>
      isDark(context) ? const Color(0x2660A5FA) : const Color(0xFFDCEBFC);
  static const Color sosBannerIconBg = Color(0xFF0F2A5C);
  static Color sosBannerText(BuildContext context) =>
      isDark(context) ? const Color(0xFFD7E6FA) : const Color(0xFF25405E);

  /// "Active" chip on the banner.
  static const Color activeChipBg = Color(0xFFDDF4E1);
  static const Color activeChipText = greenDark;

  /// Contact avatar backgrounds (rotate across contacts).
  static const List<Color> contactAvatarBg = [
    Color(0xFF0E7C86),
    Color(0xFF1D4ED8),
    Color(0xFF7C3AED),
    Color(0xFFB45309),
  ];

  /// Small relation badge on the avatar (star = primary, heart = other).
  static const Color badgePrimaryBg = success;
  static const Color badgeSecondaryBg = Color(0xFF2563EB);

  /// Relationship / role chips ("Father", "Sister").
  static Color relationChipBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFEFF1F8);
  static Color relationChipText(BuildContext context) =>
      isDark(context) ? const Color(0xFFD1D5DB) : const Color(0xFF374151);

  /// "Primary" chip.
  static const Color primaryChipBg = Color(0xFFDDF4E1);
  static const Color primaryChipText = greenDark;


  /// Round action buttons (call / edit / delete) on a contact card.
  static Color callBtnBg(BuildContext context) =>
      isDark(context) ? const Color(0x262563EB) : const Color(0xFFE8EFFD);
  static const Color callBtnIcon = Color(0xFF2563EB);
  static Color editBtnBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF3F4F6);
  static Color editBtnIcon(BuildContext context) =>
      isDark(context) ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563);
  static Color deleteBtnBg(BuildContext context) =>
      isDark(context) ? const Color(0x26DC2626) : const Color(0xFFFCE9E9);
  static const Color deleteBtnIcon = danger;

  /// "Add Emergency Contact" form card.
  static Color formFieldBg(BuildContext context) => inputBg(context);
  static Color formFieldBorder(BuildContext context) =>
      inputBorderDefault(context);
  static Color formLabel(BuildContext context) => textMutedLabel(context);
  static Color countryCodeChipBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFEFF1F8);

  /// Primary submit button ("+ Add New Trusted Contact").
  static const Color submitBtnBg = primary;
  static const Color submitBtnText = Colors.white;

  /// "Verified by Nepal Police..." strip.
  static Color verifiedStripBg(BuildContext context) =>
      isDark(context) ? const Color(0x2616A34A) : const Color(0xFFEAF8ED);
  static Color verifiedStripText(BuildContext context) =>
      isDark(context) ? const Color(0xFFBBF7D0) : const Color(0xFF15803D);

  /// "Test Alert Dispatch" card.
  static Color testAlertBg(BuildContext context) =>
      isDark(context) ? const Color(0x26F59E0B) : const Color(0xFFFCEEE9);
  static const Color testAlertIconBg = Color(0xFFFCE0D6);
  static const Color testAlertIcon = Color(0xFFEA580C);
  static const Color testLinkBorder = primary;
  static const Color testLinkText = primary;
  // ---- Added for Passenger SOS / Trusted Safety Circle screen ----
  // Relationship / badge accent colors
  static const Color pink = Color(0xFFDB2777);
  static const Color pinkBg = Color(0xFFFCE7F3);
  static const Color teal = Color(0xFF0F766E);
  static const Color tealBg = Color(0xFFCCFBF1);
  static const Color blueBadgeBg = Color(0xFFDBEAFE);
  static const Color blueBadgeText = Color(0xFF1D4ED8);
  static const Color greenBadgeBg = Color(0xFFDCFCE7);
  static const Color greenBadgeText = Color(0xFF15803D);
  static const Color pinkBadgeBg = Color(0xFFFCE7F3);
  static const Color pinkBadgeText = Color(0xFFDB2777);

  // Trusted safety circle hero banner
  static Color heroBannerBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFE8F0FE);
  static Color heroIconBg(BuildContext context) =>
      isDark(context) ? primary.withOpacity(0.4) : primary;

  // Verified banner (green tinted)
  static Color verifiedBg1(BuildContext context) =>
      isDark(context) ? const Color(0xFF14532D) : const Color(0xFFECFDF5);
  static Color verifiedText1(BuildContext context) =>
      isDark(context) ? const Color(0xFF86EFAC) : greenDark;

  // Test alert (amber/orange tinted)
  static Color testAlertIconBg1(BuildContext context) =>
      isDark(context) ? const Color(0xFF7C2D12) : const Color(0xFFFFF1EA);
  static Color testAlertIcon1(BuildContext context) =>
      isDark(context) ? const Color(0xFFFDBA74) : const Color(0xFFEA580C);

  static Color notificationDot1(BuildContext context) => danger;

  static Color iconMuted1(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  static Color divider(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  static Color deleteIconBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B1E1E) : const Color(0xFFFEF2F2);

  static Color editIconBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E293B) : const Color(0xFFF3F4F6);

  static Color callIconBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF14324D) : const Color(0xFFE8F0FE);

  // Background
  static Color background1(BuildContext context) {
    return isDark(context) ? const Color(0xFF111827) : const Color(0xFFF5F7FB);
  }
// =========================================================
  // TRACK SCREEN (Passenger) — added theme aware colors
  // =========================================================

  /// Strong action blue used for the selected filter chip,
  /// "Book Again" button and the Route badge.
  static const Color actionBlue = Color(0xFF1D4ED8);

  /// Lighter accent blue used for link-like text and numbers.
  static const Color accentBlue1 = Color(0xFF2563EB);

  /// Soft blue tint behind stat boxes, chips and info strips.
  static Color softBlue(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E293B) : const Color(0xFFEFF4FE);

  /// Slightly deeper soft blue — reward banner / highlighted rows.
  static Color softBlueStrong(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFDDE7FD);

  /// Background of the search field.
  static Color searchBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : Colors.white;

  /// Unselected filter chip background.
  static Color chipBg1(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFEFF3FA);

  /// Unselected filter chip text.
  static Color chipText1(BuildContext context) =>
      isDark(context) ? const Color(0xFFD1D5DB) : const Color(0xFF374151);

  /// Pale green pill background (Verified Ticket, CO2 saved).
  static Color successSoft(BuildContext context) =>
      isDark(context) ? const Color(0xFF14532D) : const Color(0xFFE8F8EE);

  /// Placeholder / fallback surface behind the recorded map search_route.
  static Color mapSurface1(BuildContext context) =>
      isDark(context) ? const Color(0xFF243447) : const Color(0xFFE8EEF3);

  /// Thin divider used in section headers.
  static Color divider1(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE3E8F0);

  /// Secondary (light) button background — "View e-Receipt".
  static Color buttonSoft(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E293B) : const Color(0xFFEAF1FE);

  /// Timeline rail connecting the boarding and drop points.
  static Color timelineRail(BuildContext context) =>
      isDark(context) ? const Color(0xFF475569) : const Color(0xFF9AA7BD);

  // ======================================================================
  // Added for: Passenger SOS / Live Vehicle Tracker screen
  // ======================================================================

  /// Map canvas background (the pale blue map area behind the route line).
  static Color mapBackground(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E293B) : const Color(0xFFDCE7FB);

  /// The dashed diagonal route/path line drawn on the map.
  static Color routeLine(BuildContext context) =>
      isDark(context) ? const Color(0xFF60A5FA) : const Color(0xFF3B82F6);

  /// Outer ring / pulse behind the live bus marker on the map.
  static Color busMarkerRing(BuildContext context) =>
      isDark(context) ? const Color(0x554F8EF7) : const Color(0x554F8EF7);

  /// Solid fill of the live bus marker.
  static const Color busMarkerFill = primary;

  /// "Route 104" pill background.
  static const Color routePillBg = primary;

  /// GPS / live status dot (green = healthy signal).
  static const Color gpsActiveDot = success;

  /// Floating circular map controls (locate / layers) background.
  static Color mapControlBg1(BuildContext context) => card(context);

  /// "You are here" tooltip background.
  static const Color hereTooltipBg = primary;

  /// "Fast Express" tag background / text.
  static Color tagBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A8A) : const Color(0xFFEAF1FF);

  static Color tagText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : primary;

  /// "ACTIVE" status pill.
  static Color activeBadgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF14532D) : const Color(0xFFDCFCE7);

  static Color activeBadgeText(BuildContext context) =>
      isDark(context) ? const Color(0xFF4ADE80) : greenDark;

  /// Crowd meter progress search_route / fill.
  static Color progressTrack(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  static const Color progressFill = primary;

  /// Route milestone timeline dot colors.
  static Color milestonePassed(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFF9CA3AF);

  static const Color milestoneCurrent = primary;
  static const Color milestoneDestination = success;
  static Color milestoneUpcoming(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB);

  /// "NOW" badge on the current milestone.
  static Color nowBadgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A8A) : const Color(0xFFEAF1FF);

  static Color nowBadgeText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : primary;

  /// Bottom action bar buttons (Alert / Share).
  static Color secondaryActionBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFEEF2FF);

  static Color secondaryActionText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : primary;

  /// SOS button.
  static const Color sosText = Colors.white;

}
