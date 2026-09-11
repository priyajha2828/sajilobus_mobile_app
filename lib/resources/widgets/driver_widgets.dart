import 'package:flutter/material.dart';
import '../../providers/driver_provider/issue_provider.dart';
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

/// A single diagnostic row, e.g. "VEHICLE ID / BA 2 KHA 4567 / BUS-101".
class DiagnosticInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? trailingBadge;
  final bool showDivider;

  const DiagnosticInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.trailingBadge,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDivider)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, color: CustomColor.border(context)),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: CustomColor.iconMuted(context)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: CustomColor.textMutedLabel(context),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                ],
              ),
            ),
            if (trailingBadge != null)
              TagChip(
                label: trailingBadge!,
                background: CustomColor.chipBg(context),
                foreground: CustomColor.chipText(context),
              ),
          ],
        ),
      ],
    );
  }
}
/// Editable issue-description text area with a character counter and a
/// "Telemetry synced" status footer.
class DescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final bool isSynced;
  final ValueChanged<String>? onChanged;

  const DescriptionField({
    super.key,
    required this.controller,
    required this.maxLength,
    this.isSynced = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            onChanged: onChanged,
            maxLength: maxLength,
            maxLines: 5,
            minLines: 3,
            style: TextStyle(
              fontSize: 13,
              color: CustomColor.textPrimary(context),
              height: 1.4,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              counterText: '',
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${controller.text.length} / $maxLength characters',
                style: TextStyle(
                  fontSize: 11,
                  color: CustomColor.textMutedLabel(context),
                ),
              ),
              if (isSynced)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle,
                        size: 14, color: CustomColor.syncedText(context)),
                    const SizedBox(width: 4),
                    Text(
                      'Telemetry synced',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.syncedText(context),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
// Horizontal stepper showing incident progress across
/// Submitted → Under Review → Dispatched → Resolved.
class IncidentStepper extends StatelessWidget {
  final IncidentStage currentStage;

  const IncidentStepper({super.key, required this.currentStage});

  @override
  Widget build(BuildContext context) {
    final stages = IncidentStage.values;
    return Row(
      children: [
        for (int i = 0; i < stages.length; i++) ...[
          Expanded(
            child: _StageNode(
              stage: stages[i],
              state: _stateFor(stages[i]),
            ),
          ),
          if (i != stages.length - 1)
            Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.only(bottom: 28),
                color: i < currentStage.index
                    ? CustomColor.stepperDone
                    : CustomColor.stepperLine(context),
              ),
            ),
        ],
      ],
    );
  }

  _NodeState _stateFor(IncidentStage stage) {
    if (stage.index < currentStage.index) return _NodeState.done;
    if (stage.index == currentStage.index) return _NodeState.active;
    return _NodeState.pending;
  }
}

enum _NodeState { done, active, pending }

class _StageNode extends StatelessWidget {
  final IncidentStage stage;
  final _NodeState state;

  const _StageNode({required this.stage, required this.state});

  @override
  Widget build(BuildContext context) {
    Color circleColor;
    IconData? icon;
    Color labelColor;

    switch (state) {
      case _NodeState.done:
        circleColor = CustomColor.stepperDone;
        icon = Icons.check;
        labelColor = CustomColor.textPrimary(context);
        break;
      case _NodeState.active:
        circleColor = CustomColor.stepperActive;
        icon = Icons.radio_button_checked;
        labelColor = CustomColor.stepperLabelActive(context);
        break;
      case _NodeState.pending:
        circleColor = CustomColor.stepperPending(context);
        icon = null;
        labelColor = CustomColor.stepperLabelMuted(context);
        break;
    }

    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: state == _NodeState.pending ? Colors.transparent : circleColor,
            shape: BoxShape.circle,
            border: state == _NodeState.pending
                ? Border.all(color: circleColor, width: 2)
                : null,
          ),
          child: icon == null
              ? null
              : Icon(icon, size: 15, color: CustomColor.onDark),
        ),
        const SizedBox(height: 6),
        Text(
          stage.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          stage.subLabel,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: CustomColor.stepperLabelMuted(context),
          ),
        ),
      ],
    );
  }
}

