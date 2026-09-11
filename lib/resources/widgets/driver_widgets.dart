import 'package:flutter/material.dart';
import '../card/driver_card.dart';
import '../chip/driver_chip.dart';
import '../color/custom_color.dart';
import '../label/label.dart';

/// The 3-column stat row (Rating / Safety / Tenure)
class StatColumn extends StatelessWidget {
  final Widget top;
  final String value;
  final String label;

  const StatColumn({
    super.key,
    required this.top,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          top,
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: CustomColor.textPrimary(context),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.5,
              color: CustomColor.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}
/// Plate + Fleet designation row inside telemetry card
class PlateDesignationRow extends StatelessWidget {
  final String plateNepali;
  final String fleetDesignation;

  const PlateDesignationRow({
    super.key,
    required this.plateNepali,
    required this.fleetDesignation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CustomColor.telemetryTileBg(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plateNepali,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: CustomColor.textPrimary(context),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Fleet Designation',
                style: TextStyle(
                  fontSize: 11,
                  color: CustomColor.textSecondary(context),
                ),
              ),
              Text(
                fleetDesignation,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.accentBlue(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Map placeholder with a location pill overlay
class MapPlaceholder extends StatelessWidget {
  final String locationLabel;

  const MapPlaceholder({super.key, required this.locationLabel});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [CustomColor.mapGradientTop, CustomColor.mapGradientBottom],
          ),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.change_history_rounded,
                      size: 13, color: CustomColor.warning),
                  const SizedBox(width: 6),
                  Text(
                    locationLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Quick log text box with a mic "Add Audio" action
class QuickLogBox extends StatelessWidget {
  final String logText;
  final bool isRecording;
  final VoidCallback onAddAudio;
  final List<String> tags;

  const QuickLogBox({
    super.key,
    required this.logText,
    required this.isRecording,
    required this.onAddAudio,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return EmergencySectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NumberedSectionLabel(title: '2. SITUATION QUICK LOG'),
              InkWell(
                onTap: onAddAudio,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: CustomColor.accentBlueBg(context),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isRecording ? Icons.mic : Icons.mic_none_rounded,
                        size: 14,
                        color: CustomColor.accentBlue(context),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isRecording ? 'Recording…' : 'Add Audio',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.accentBlue(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CustomColor.bg_color(context),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.edit_note_rounded,
                    size: 16, color: CustomColor.textSecondary(context)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    logText,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((t) => LogTagChip(label: t)).toList(),
          ),
        ],
      ),
    );
  }
}
/// Screen's own top app bar (part of this screen, not the shared bottom nav)
class EmergencyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String avatarUrl;
  final VoidCallback onBack;

  const EmergencyAppBar({
    super.key,
    required this.title,
    required this.avatarUrl,
    required this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.card(context),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 58,
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: Icon(Icons.arrow_back,
                    color: CustomColor.textPrimary(context)),
              ),
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: CustomColor.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.directions_bus,
                    size: 18, color: Colors.white),
              ),
              const SizedBox(width: 10),
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
              CircleAvatar(
                radius: 16,
                backgroundColor: CustomColor.border(context),
                backgroundImage: NetworkImage(avatarUrl),
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}
