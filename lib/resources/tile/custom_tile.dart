import 'package:flutter/material.dart';

import '../../providers/driver_provider/sos_provider.dart';
import '../../providers/driver_provider/stop_management_provider.dart';
import '../../providers/driver_provider/trip_provider.dart';
import '../chip/custom_chip.dart';
import '../color/custom_color.dart';
import '../label/label.dart';


class StopTile extends StatelessWidget {
  final String title;
  final String trailing;
  final bool completed;

  const StopTile({
    super.key,
    required this.title,
    required this.trailing,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: CircleAvatar(
        radius: 20,
        backgroundColor: completed
            ? CustomColor.success
            : CustomColor.primary,
        child: Icon(
          completed
              ? Icons.check
              : Icons.location_on,
          color: Colors.white,
          size: 20,
        ),
      ),

      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: CustomColor.textPrimary(context),
        ),
      ),

      trailing: Text(
        trailing,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: completed
              ? CustomColor.success
              : CustomColor.primary,
        ),
      ),
    );
  }
}
class TimelineTileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool completed;
  final bool current;
  final String trailing;

  const TimelineTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.completed,
    required this.current,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: current
            ? CustomColor.primary
            : completed
            ? CustomColor.success
            : Colors.grey.shade300,
        child: Icon(
          completed
              ? Icons.check
              : Icons.location_on,
          color: Colors.white,
        ),
      ),

      title: Text(title),

      subtitle: Text(subtitle),

      trailing: Text(
        trailing,
        style: TextStyle(
          color: current
              ? CustomColor.primary
              : CustomColor.textSecondary(context),
        ),
      ),
    );
  }
}
/// One row inside the "Route Stop Timeline" list, including the
/// leading status circle and connecting vertical line.
class RouteStopTile extends StatelessWidget {
  final RouteStop stop;
  final bool isLast;

  const RouteStopTile({super.key, required this.stop, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final circle = _buildCircle(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              circle,
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: CustomColor.timelineLine(context),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${stop.index}. ${stop.name}',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: CustomColor.textPrimary(context),
                          ),
                        ),
                      ),
                      if (stop.status == StopStatus.current)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: CustomColor.currentChipBg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'CURRENT',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        )
                      else if (stop.timeLabel.isNotEmpty)
                        Text(
                          stop.timeLabel,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.textSecondary(context),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          stop.subtitle,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: CustomColor.textSecondary(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (stop.status == StopStatus.current &&
                      (stop.extraInfo != null || stop.extraInfoSecondary != null)) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        if (stop.extraInfo != null)
                          _extraChip(context, Icons.login, stop.extraInfo!),
                        if (stop.extraInfo != null && stop.extraInfoSecondary != null)
                          const SizedBox(width: 10),
                        if (stop.extraInfoSecondary != null)
                          _extraChip(context, Icons.logout, stop.extraInfoSecondary!),
                      ],
                    ),
                  ],
                  if (stop.status == StopStatus.upcoming && stop.etaLabel != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      stop.etaLabel!,
                      style: TextStyle(
                        fontSize: 12,
                        color: CustomColor.textMutedLabel(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _extraChip(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: CustomColor.textMutedLabel(context)),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 12, color: CustomColor.textMutedLabel(context)),
        ),
      ],
    );
  }

  Widget _buildCircle(BuildContext context) {
    switch (stop.status) {
      case StopStatus.completed:
        return CircleAvatar(
          radius: 15,
          backgroundColor: CustomColor.stopCompletedBg(context),
          child: const Icon(Icons.check, size: 16, color: CustomColor.stopCompleted),
        );
      case StopStatus.current:
        return CircleAvatar(
          radius: 15,
          backgroundColor: CustomColor.stopCurrentBg(context),
          child: const CircleAvatar(radius: 6, backgroundColor: CustomColor.stopCurrent),
        );
      case StopStatus.upcoming:
        return CircleAvatar(
          radius: 15,
          backgroundColor: CustomColor.stopUpcomingBg(context),
          child: Text(
            '${stop.index}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: CustomColor.stopUpcomingText(context),
            ),
          ),
        );
      case StopStatus.finalStop:
        return CircleAvatar(
          radius: 15,
          backgroundColor: CustomColor.stopUpcomingBg(context),
          child: const Icon(Icons.flag, size: 14, color: CustomColor.stopFinal),
        );
    }
  }
}
/// One chip in the "All 8 / Admin & Dispatch 3 / Route Updates 2 ..."
/// filter row. Shows a pill with a label and a count badge, and adapts
/// its color depending on whether it's selected.
class FilterChipTile extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  const FilterChipTile({
    super.key,
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? CustomColor.filterChipSelectedBg : CustomColor.filterChipBg(context),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? CustomColor.filterChipSelectedText
                      : CustomColor.filterChipText(context),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: selected
                      ? CustomColor.filterChipSelectedCountBg
                      : CustomColor.card(context),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? CustomColor.filterChipSelectedText
                        : CustomColor.filterChipCountText(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/// Credential row: icon + label + value (+ optional verified subtitle)
class CredentialTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? verifiedSubtitle;
  final Color? valueColor;

  const CredentialTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.verifiedSubtitle,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: CustomColor.textSecondary(context)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.5,
                color: CustomColor.textSecondary(context),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? CustomColor.textPrimary(context),
                ),
              ),
              if (verifiedSubtitle != null) ...[
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle,
                        size: 13, color: CustomColor.success),
                    const SizedBox(width: 3),
                    Text(
                      verifiedSubtitle!,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.success,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// Preference row with a trailing switch
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconChip(icon: icon),
          const SizedBox(width: 12),
          Expanded(child: TitleSubtitle(title: title, subtitle: subtitle)),
          Switch.adaptive(
            value: value,
            activeColor: CustomColor.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// Preference row with a trailing chip / value badge (e.g. Night Mode, Language)
class ActionChipTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String chipLabel;
  final VoidCallback? onTap;

  const ActionChipTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.chipLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconChip(icon: icon),
            const SizedBox(width: 12),
            Expanded(child: TitleSubtitle(title: title, subtitle: subtitle)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: CustomColor.bg_color(context),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: CustomColor.border(context)),
              ),
              child: Text(
                chipLabel,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Preference row with a trailing refresh/status icon (offline map)
class StatusIconTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String statusText;
  final Color statusColor;
  final IconData trailingIcon;
  final VoidCallback? onTrailingTap;

  const StatusIconTile({
    super.key,
    required this.icon,
    required this.title,
    required this.statusText,
    required this.statusColor,
    required this.trailingIcon,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconChip(icon: icon),
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
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  statusText,
                  style: TextStyle(fontSize: 12.5, color: statusColor),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTrailingTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(trailingIcon,
                  size: 18, color: CustomColor.textSecondary(context)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dispatch/Help navigation row (icon + title + subtitle + chevron)
class DispatchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const DispatchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            IconChip(icon: icon),
            const SizedBox(width: 12),
            Expanded(child: TitleSubtitle(title: title, subtitle: subtitle)),
            Icon(Icons.chevron_right,
                color: CustomColor.textSecondary(context)),
          ],
        ),
      ),
    );
  }
}
/// One emergency type selection tile (grid item)
class EmergencyTypeTile extends StatelessWidget {
  final EmergencyTypeOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const EmergencyTypeTile({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? CustomColor.typeTileSelectedBg(context)
              : CustomColor.typeTileBg(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? CustomColor.typeTileSelectedBorder(context)
                : CustomColor.border(context),
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  iconFromKey(option.icon),
                  size: 20,
                  color: isSelected ? Colors.white : CustomColor.textPrimary(context),
                ),
                const SizedBox(height: 10),
                Text(
                  option.title,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  option.subtitle,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: isSelected
                        ? Colors.white.withOpacity(0.85)
                        : CustomColor.textSecondary(context),
                  ),
                ),
              ],
            ),
            if (isSelected)
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(Icons.circle, size: 8, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
/// Generic 2-column telemetry info tile (Coordinates, Passenger Manifest, Route, Duty Captain)
class TelemetryInfoTile extends StatelessWidget {
  final String label;
  final Widget value;
  final String? footnote;
  final Color? footnoteColor;

  const TelemetryInfoTile({
    super.key,
    required this.label,
    required this.value,
    this.footnote,
    this.footnoteColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CustomColor.telemetryTileBg(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: CustomColor.textSecondary(context),
            ),
          ),
          const SizedBox(height: 6),
          value,
          if (footnote != null) ...[
            const SizedBox(height: 4),
            Text(
              footnote!,
              style: TextStyle(
                fontSize: 11.5,
                color: footnoteColor ?? CustomColor.textSecondary(context),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
class VoiceChannelTile extends StatelessWidget {
  final VoiceChannel channel;
  final Color accentColor;
  final VoidCallback onTap;

  const VoiceChannelTile({
    super.key,
    required this.channel,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: CustomColor.card(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: CustomColor.border(context)),
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: CustomColor.voiceChannelIconBg(context, base: accentColor),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(iconFromKey(channel.icon), size: 18, color: accentColor),
            ),
            const SizedBox(height: 8),
            Text(
              channel.label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: CustomColor.textPrimary(context),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              channel.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: CustomColor.textSecondary(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/// One of the three stat tiles: Waiting / Boarded / Dropped.
class StatCounterTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color background;
  final Color accent;
  final bool showControls;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const StatCounterTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.background,
    required this.accent,
    this.showControls = false,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: accent),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
          if (showControls) ...[
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundIconButton(icon: Icons.add, color: accent, onTap: onIncrement),
                RoundIconButton(icon: Icons.remove, color: accent, onTap: onDecrement),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Small circular +/- button used inside [StatCounterTile].
class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const RoundIconButton({
    super.key,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 14, color: color),
      ),
    );
  }
}
/// One row in the corridor timeline (with connecting line + node).
class TimelineTile extends StatelessWidget {
  final WaypointModel waypoint;
  final bool isLast;

  const TimelineTile({super.key, required this.waypoint, this.isLast = false});

  Color _nodeColor(BuildContext context) {
    switch (waypoint.status) {
      case WaypointStatus.completed:
        return CustomColor.timelineCompleted;
      case WaypointStatus.active:
        return CustomColor.timelineActive;
      case WaypointStatus.upcoming:
        return CustomColor.timelineUpcoming(context);
      case WaypointStatus.finalDestination:
        return CustomColor.timelineFinal;
    }
  }

  Widget _node(BuildContext context) {
    final color = _nodeColor(context);
    IconData? icon;
    bool filled = true;

    switch (waypoint.status) {
      case WaypointStatus.completed:
        icon = Icons.check;
        break;
      case WaypointStatus.active:
        icon = Icons.circle;
        break;
      case WaypointStatus.upcoming:
        icon = null;
        filled = false;
        break;
      case WaypointStatus.finalDestination:
        icon = Icons.flag;
        break;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: filled ? color : Colors.transparent,
        shape: BoxShape.circle,
        border: filled ? null : Border.all(color: color, width: 2),
      ),
      child: icon == null
          ? null
          : Icon(
        icon,
        size: waypoint.status == WaypointStatus.active ? 10 : 16,
        color: Colors.white,
      ),
    );
  }

  Widget _subLine(BuildContext context) {
    final muted = CustomColor.textSecondary(context);
    switch (waypoint.status) {
      case WaypointStatus.completed:
        return Row(
          children: [
            TagChip(
              label: 'Completed',
              background: CustomColor.badgeGreenBg(context),
              foreground: CustomColor.badgeGreenText(context),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '+${waypoint.boarded ?? 0} Boarded  •  ${waypoint.dropped == 0 ? '0' : '-${waypoint.dropped}'} Dropped',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: muted),
              ),
            ),
          ],
        );
      case WaypointStatus.active:
        return Text(
          '+${waypoint.boarded ?? 0} Boarded  •  -${waypoint.dropped ?? 0} Dropped  •  ${waypoint.waiting ?? 0} Waiting',
          style: TextStyle(fontSize: 12, color: muted),
        );
      case WaypointStatus.upcoming:
        final extra = waypoint.prebooked != null
            ? '${waypoint.prebooked} Pre-booked'
            : waypoint.waiting != null
            ? '${waypoint.waiting} Waiting'
            : '';
        return Text(
          extra.isEmpty ? 'Upcoming' : 'Upcoming  •  $extra',
          style: TextStyle(fontSize: 12, color: muted),
        );
      case WaypointStatus.finalDestination:
        return TagChip(
          label: 'Final Destination',
          background: CustomColor.stageBadgeBg(context),
          foreground: CustomColor.textSecondary(context),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isActive = waypoint.status == WaypointStatus.active;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _node(context),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: CustomColor.timelineLine(context),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20, top: 2),
              child: Container(
                padding: isActive
                    ? const EdgeInsets.all(10)
                    : EdgeInsets.zero,
                decoration: isActive
                    ? BoxDecoration(
                  color: CustomColor.chipBg(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: CustomColor.timelineActive.withOpacity(0.4),
                  ),
                )
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${waypoint.index}. ${waypoint.name}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: CustomColor.textPrimary(context),
                            ),
                          ),
                        ),
                        if (isActive)
                          TagChip(
                            label: 'ACTIVE NOW',
                            background: CustomColor.timelineActive,
                            foreground: Colors.white,
                          )
                        else
                          Text(
                            waypoint.timeLabel,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: CustomColor.timelineActive,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _subLine(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// One tile in the "Select Issue Category" grid.
class CategoryTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? CustomColor.categorySelectedBg(context)
        : CustomColor.categoryTileBg(context);
    final border = selected
        ? CustomColor.categorySelectedBorder(context)
        : CustomColor.categoryTileBorder(context);
    final iconColor = selected
        ? CustomColor.categorySelectedIcon(context)
        : CustomColor.categoryTileIcon(context);
    final textColor = selected
        ? CustomColor.categorySelectedIcon(context)
        : CustomColor.textPrimary(context);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border, width: selected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/// A captured photo thumbnail with a label and a remove ("x") button.
class PhotoThumbnailTile extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const PhotoThumbnailTile({
    super.key,
    required this.label,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 84,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 84,
                height: 64,
                decoration: BoxDecoration(
                  color: CustomColor.photoTileBg(context),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.image_outlined,
                    color: CustomColor.iconMuted(context)),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textSecondary(context),
                ),
              ),
            ],
          ),
          Positioned(
            top: -6,
            right: -6,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: CustomColor.removeButtonBg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 12, color: CustomColor.onDark),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dashed placeholder tile the driver taps to add another photo.
class AddPhotoTile extends StatelessWidget {
  final VoidCallback onTap;

  const AddPhotoTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 84,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: CustomColor.addPhotoBorder(context),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_outlined,
                size: 18, color: CustomColor.addPhotoIcon(context)),
            const SizedBox(height: 4),
            Text(
              'Add Photo',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: CustomColor.textMutedLabel(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A small label/value tile, e.g. "Duration / 1h 45m".
class MiniStatTile extends StatelessWidget {
  final String label;
  final String value;

  const MiniStatTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: CustomColor.bg_color(context),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: CustomColor.textMutedLabel(context),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: CustomColor.textPrimary(context),
            ),
          ),
        ],
      ),
    );
  }
}


/// One tile in the "Quick Transit Hub" 3-column grid.
class QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isHighlighted;
  final int? badgeCount;
  final VoidCallback onTap;

  const QuickActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isHighlighted = false,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isHighlighted ? CustomColor.sosTileBg : CustomColor.categoryTileBg(context);
    final iconColor = isHighlighted ? CustomColor.sosTileText : CustomColor.categoryTileIcon(context);
    final textColor = isHighlighted ? CustomColor.sosTileText : CustomColor.textPrimary(context);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: isHighlighted
              ? null
              : Border.all(color: CustomColor.categoryTileBorder(context)),
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 22, color: iconColor),
                if (badgeCount != null)
                  Positioned(
                    top: -4,
                    right: -10,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      decoration: const BoxDecoration(
                        color: CustomColor.countBadgeBg,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$badgeCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: CustomColor.countBadgeText,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


