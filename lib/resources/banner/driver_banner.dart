import 'package:flutter/material.dart';
import '../color/custom_color.dart';

/// Blue info banner: "⏱ Duration: 1h 10m elapsed   ⇅ 3 stops remaining".
class InfoBanner extends StatelessWidget {
  final String durationLabel;
  final int stopsRemaining;

  const InfoBanner({
    super.key,
    required this.durationLabel,
    required this.stopsRemaining,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: CustomColor.infoBannerBg(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.timer_outlined, size: 16, color: CustomColor.infoBannerText(context)),
              const SizedBox(width: 6),
              Text('Duration: $durationLabel',
                  style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.infoBannerText(context))),
            ],
          ),
          Row(
            children: [
              Icon(Icons.swap_vert, size: 16, color: CustomColor.infoBannerText(context)),
              const SizedBox(width: 6),
              Text('$stopsRemaining stops remaining',
                  style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.infoBannerText(context))),
            ],
          ),
        ],
      ),
    );
  }
}


/// "NEXT DIRECTION" banner overlaid at the bottom of the map card.
class NextDirectionBanner extends StatelessWidget {
  final String instruction;
  final String distance;

  const NextDirectionBanner({
    super.key,
    required this.instruction,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: CustomColor.nextDirectionBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: CustomColor.nextDirectionIconBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.turn_slight_right, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'NEXT DIRECTION',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  instruction,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            distance,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
/// Bottom promo banner: "Alert Preferences — Manage SMS alerts for
/// mountain road closures".
class AlertPreferencesBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const AlertPreferencesBanner({
    super.key,
    this.title = 'Alert Preferences',
    this.subtitle = 'Manage SMS alerts for mountain road closures',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColor.alertPrefsBg(context),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: CustomColor.alertPrefsIconBg(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.tune, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: CustomColor.alertPrefsTitle(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: CustomColor.alertPrefsSubtitle(context),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: CustomColor.alertPrefsSubtitle(context)),
            ],
          ),
        ),
      ),
    );
  }
}
/// Warning banner shown below logout button
class WarningBanner extends StatelessWidget {
  final String text;
  final String highlight;

  const WarningBanner({super.key, required this.text, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CustomColor.warningBg(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded,
              size: 18, color: CustomColor.warning),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12.5,
                  color: CustomColor.textSecondary(context),
                  height: 1.4,
                ),
                children: [
                  TextSpan(text: text),
                  TextSpan(
                    text: highlight,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: CustomColor.danger,
                    ),
                  ),
                  const TextSpan(
                      text: ' on dispatch radar. Make sure your shift handover is logged.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/// Red hero banner: PRIORITY CHANNEL + CRITICAL LIVE badge + title + subtitle
class EmergencyHeroBanner extends StatelessWidget {
  final String channelLabel;
  final String liveBadge;
  final String title;
  final String subtitle;

  const EmergencyHeroBanner({
    super.key,
    required this.channelLabel,
    required this.liveBadge,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [CustomColor.emergencyRedDark, CustomColor.emergencyRed],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning_rounded,
                      size: 14, color: Colors.white70),
                  const SizedBox(width: 6),
                  Text(
                    channelLabel,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  liveBadge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

