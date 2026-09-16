import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/passenger_provider/sos_provider.dart';
import '../color/custom_color.dart';


/// Shared rounded-card decoration wrapper used across the screen.
class SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SectionCard({
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
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.border(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Top red "Emergency Transit ..." banner with live indicator.
class EmergencyBannerTile extends StatelessWidget {
  const EmergencyBannerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            CustomColor.emergencyBannerStart(context),
            CustomColor.emergencyBannerEnd(context),
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Emergency Transit ...',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Direct priority link to Nepal Police (100) & Central ...',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: CustomColor.liveLinePill(context),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'LIVE\nLINE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: CustomColor.liveDot,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// "High-Precision Telemetry Lock" row with accuracy pill.
class TelemetryLockTile extends StatelessWidget {
  const TelemetryLockTile({super.key});

  @override
  Widget build(BuildContext context) {
    final gps = context.watch<EmergencyProvider>().gpsFix;
    return Row(
      children: [
        Icon(Icons.gps_fixed, size: 18, color: CustomColor.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'HIGH-PRECISION TELEMETRY LOCK',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
              color: CustomColor.textPrimary(context),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: CustomColor.accuracyBadgeBg(context),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: CustomColor.accuracyBadgeText(context),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                gps.accuracyLabel,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.accuracyBadgeText(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Auto-detected GPS coordinates card.
class GpsCoordinatesTile extends StatelessWidget {
  const GpsCoordinatesTile({super.key});

  @override
  Widget build(BuildContext context) {
    final gps = context.watch<EmergencyProvider>().gpsFix;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CustomColor.gpsCardBg(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.my_location, size: 18, color: CustomColor.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AUTO-DETECTED GPS COORDINATES',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  gps.coordinates,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.near_me, size: 12, color: CustomColor.textSecondary(context)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        gps.nearestLandmark,
                        style: TextStyle(fontSize: 12, color: CustomColor.textSecondary(context)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Vehicle chip: plate, route name/detail and current speed.
class VehicleInfoTile extends StatelessWidget {
  const VehicleInfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicle = context.watch<EmergencyProvider>().vehicle;
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: CustomColor.vehicleChipBg(context),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.directions_bus, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vehicle.plate,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.textPrimary(context),
                ),
              ),
              Text(
                vehicle.routeLabel,
                style: TextStyle(fontSize: 11, color: CustomColor.textSecondary(context)),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: CustomColor.speedChipBg(context),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Speed: ${vehicle.speedKmh} km/h',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: CustomColor.speedChipText(context),
            ),
          ),
        ),
      ],
    );
  }
}

/// "Live Dispatch Lifecycle" 3-step stepper.
class DispatchLifecycleTile extends StatelessWidget {
  const DispatchLifecycleTile({super.key});

  @override
  Widget build(BuildContext context) {
    final stage = context.watch<EmergencyProvider>().dispatchStage;

    Widget step({
      required IconData icon,
      required String label,
      required String sub,
      required bool active,
      required bool completed,
    }) {
      final color = (active || completed) ? CustomColor.stepActive(context) : CustomColor.stepInactive(context);
      return Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: (active || completed) ? color : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(
              completed ? Icons.check : icon,
              size: 18,
              color: (active || completed) ? Colors.white : color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: (active || completed) ? CustomColor.textPrimary(context) : CustomColor.textMutedLabel(context),
            ),
          ),
          Text(
            sub,
            style: TextStyle(fontSize: 10, color: CustomColor.textMutedLabel(context)),
          ),
        ],
      );
    }

    Widget line(bool active) => Expanded(
      child: Container(
        height: 2,
        color: active ? CustomColor.stepLineActive(context) : CustomColor.stepLineInactive(context),
      ),
    );

    final pendingActive = true;
    final inProgressActive = stage == DispatchStage.inProgress || stage == DispatchStage.resolved;
    final resolvedActive = stage == DispatchStage.resolved;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'LIVE DISPATCH LIFECYCLE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
                color: CustomColor.textPrimary(context),
              ),
            ),
            Text(
              'Stage 1 Active',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CustomColor.primary),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            step(icon: Icons.radio_button_checked, label: 'PENDING', sub: 'Armed', active: pendingActive, completed: false),
            line(inProgressActive),
            step(icon: Icons.podcasts, label: 'IN_PROGRESS', sub: 'Fleet Notified', active: inProgressActive, completed: false),
            line(resolvedActive),
            step(icon: Icons.verified_outlined, label: 'RESOLVED', sub: 'Safe & Closed', active: resolvedActive, completed: resolvedActive),
          ],
        ),
      ],
    );
  }
}

/// A single selectable "Nature of Emergency" card.
class EmergencyTypeCard extends StatelessWidget {
  final EmergencyType type;

  const EmergencyTypeCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EmergencyProvider>();
    final selected = provider.isSelected(type.id);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => context.read<EmergencyProvider>().toggleEmergencyType(type.id),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CustomColor.emergencyTypeCardBg(context, selected: selected, accent: type.accent),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CustomColor.emergencyTypeCardBorder(context, selected: selected, accent: type.accent),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(type.icon, size: 20, color: type.accent),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                  Text(
                    type.subtitle,
                    style: TextStyle(fontSize: 11, color: CustomColor.textSecondary(context)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 2x2 grid of emergency type cards.
class EmergencyTypeGrid extends StatelessWidget {
  const EmergencyTypeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final types = context.watch<EmergencyProvider>().emergencyTypes;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.6,
      children: types.map((t) => EmergencyTypeCard(type: t)).toList(),
    );
  }
}

/// "Incident Details (Optional)" input with mic affordance.
class IncidentDetailsField extends StatelessWidget {
  const IncidentDetailsField({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<EmergencyProvider>();
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.inputBg(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CustomColor.inputBorderDefault(context)),
      ),
      child: TextField(
        controller: provider.incidentDetailsController,
        maxLines: 2,
        style: TextStyle(fontSize: 13, color: CustomColor.textPrimary(context)),
        decoration: InputDecoration(
          hintText: 'Optional details for control room & emergency contacts...',
          hintStyle: TextStyle(fontSize: 13, color: CustomColor.inputHintDefault(context)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 6, bottom: 6),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(color: CustomColor.primary, shape: BoxShape.circle),
                child: const Icon(Icons.mic_none, size: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Big circular "hold to activate" SOS button with progress ring.
class SosHoldButton extends StatelessWidget {
  const SosHoldButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EmergencyProvider>();

    return GestureDetector(
      onLongPressStart: (_) => context.read<EmergencyProvider>().startSosHold(),
      onLongPressEnd: (_) => context.read<EmergencyProvider>().cancelSosHold(),
      onLongPressCancel: () => context.read<EmergencyProvider>().cancelSosHold(),
      child: SizedBox(
        width: 190,
        height: 190,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColor.sosOuterGlow(context),
              ),
            ),
            SizedBox(
              width: 168,
              height: 168,
              child: CircularProgressIndicator(
                value: provider.sosProgress == 0 ? null : provider.sosProgress,
                strokeWidth: 4,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                  provider.sosProgress > 0 ? CustomColor.danger : Colors.transparent,
                ),
              ),
            ),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [CustomColor.sosButtonStart, CustomColor.sosButtonEnd],
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColor.danger.withOpacity(0.35),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.power_settings_new, color: Colors.white, size: 34),
                  const SizedBox(height: 4),
                  const Text(
                    'SOS',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    provider.isSosActivated ? 'SENT' : 'HOLD 2S',
                    style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small caption row under the SOS button explaining what it does.
class SosDescriptionText extends StatelessWidget {
  const SosDescriptionText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(fontSize: 12.5, color: CustomColor.textSecondary(context), height: 1.4),
        children: [
          const TextSpan(text: 'Instantly alerts '),
          TextSpan(
            text: 'Police Transit Control (100)',
            style: TextStyle(fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
          ),
          const TextSpan(text: ' and your 2 designated emergency contacts with encrypted live GPS updates.'),
        ],
      ),
    );
  }
}

/// A single quick-call button (e.g. "Call 100", "Call 103").
class QuickCallButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color background;
  final VoidCallback? onTap;

  const QuickCallButton({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.background,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 10.5)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One key/value row inside the "Central Transit Dispatch Preview" card.
class DispatchDetailRow extends StatelessWidget {
  final String label;
  final Widget value;

  const DispatchDetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: CustomColor.textMutedLabel(context)),
            ),
          ),
          Expanded(child: value),
        ],
      ),
    );
  }
}

/// Full "Central Transit Dispatch Preview" card.
class DispatchPreviewCard extends StatelessWidget {
  const DispatchPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield_outlined, size: 18, color: CustomColor.success),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Central Transit Dispatch\nPreview',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: CustomColor.monitoredBadgeBg(context),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'MONITORED 24/7',
                  style: TextStyle(color: CustomColor.monitoredBadgeText, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Divider(height: 24, color: CustomColor.border(context)),
          DispatchDetailRow(
            label: 'Primary Dispatch Unit:',
            value: Text(
              'Itahari Transit Control Desk',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: CustomColor.textPrimary(context)),
            ),
          ),
          DispatchDetailRow(
            label: 'Dispatch Protocol:',
            value: Text(
              'Priority Intercept #NEP-9021',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: CustomColor.primary),
            ),
          ),
          DispatchDetailRow(
            label: 'Registered Family Alert:',
            value: Row(
              children: [
                Icon(Icons.check_circle, size: 14, color: CustomColor.success),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '2 Contacts Armed (SMS + Live Pin)',
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: CustomColor.textPrimary(context)),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 24, color: CustomColor.border(context)),
          Row(
            children: [
              Icon(Icons.lock_outline, size: 14, color: CustomColor.textMutedLabel(context)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Encrypted Gov Transit Channel',
                  style: TextStyle(fontSize: 11.5, color: CustomColor.textMutedLabel(context)),
                ),
              ),
              Text(
                'Dispatch settings',
                style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: CustomColor.primary),
              ),
              Icon(Icons.chevron_right, size: 16, color: CustomColor.primary),
            ],
          ),
        ],
      ),
    );
  }
}

/// Reusable section title row, e.g. "Nature of Emergency" + "Select one or more".
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;

  const SectionHeader({super.key, required this.title, this.actionLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: CustomColor.textPrimary(context)),
        ),
        if (actionLabel != null)
          Text(
            actionLabel!,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CustomColor.danger),
          ),
      ],
    );
  }
}

/// Footer "Accidental Tap? Return to Navigation Safely" text.
class SafeReturnFooter extends StatelessWidget {
  final VoidCallback? onTap;
  const SafeReturnFooter({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onTap,
        child: Text(
          'Accidental Tap? Return to Navigation Safely',
          style: TextStyle(fontSize: 12.5, color: CustomColor.textMutedLabel(context), fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}