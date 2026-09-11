import 'package:flutter/material.dart';

import '../../routes/app_route.dart';
import '../color/custom_color.dart';


/// Large primary "REACHED STOP" action button.
class ReachedStopButton extends StatelessWidget {
  final VoidCallback onTap;
  const ReachedStopButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColor.actionReachedBg,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        icon: const Icon(Icons.check_circle_outline),
        label: const Text(
          'REACHED STOP',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
        ),
      ),
    );
  }
}

/// Secondary "SKIP STOP" / danger "EMERGENCY" action buttons row.
class SkipAndEmergencyRow extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onEmergency;

  const SkipAndEmergencyRow({
    super.key,
    required this.onSkip,
    required this.onEmergency,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton.icon(
              onPressed: onSkip,
              style: OutlinedButton.styleFrom(
                backgroundColor: CustomColor.actionSkipBg(context),
                foregroundColor: CustomColor.actionSkipText(context),
                side: BorderSide(color: CustomColor.border(context)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.redo, size: 18),
              label: const Text('SKIP STOP', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: onEmergency,
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.actionEmergencyBg,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              icon: const Icon(Icons.warning_amber_rounded, size: 18),
              label: const Text('EMERGENCY', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      ],
    );
  }
}

// Small round floating button used for map controls
/// (compass, traffic-signal toggle, zoom in/out).
class MapControlButton extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const MapControlButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? CustomColor.mapControlActiveBg : CustomColor.mapControlBg(context),
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 18,
            color: active ? Colors.white : CustomColor.mapControlIcon(context),
          ),
        ),
      ),
    );
  }
}
/// Floating red "SOS" circular button (bottom-right, overlapping the
/// action buttons card, as in the design).
class SosFloatingButton extends StatelessWidget {
  final VoidCallback onTap;
  const SosFloatingButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColor.sosBg,
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: (){
          Navigator.pushNamed(context, AppRoute.sos);
        },
        child: Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          child: const Text(
            'SOS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
 /// Blue "↴ Mark all read" pill button shown next to the notifications
/// title.
class MarkAllReadButton extends StatelessWidget {
  final VoidCallback onTap;
  const MarkAllReadButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColor.markAllReadBg(context),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.done_all, size: 15, color: CustomColor.markAllReadText(context)),
              const SizedBox(width: 6),
              Text(
                'Mark all read',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.markAllReadText(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/// Logout button with danger styling
class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const LogoutButton({super.key, required this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: CustomColor.dangerBg(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: CustomColor.dangerBorder(context)),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: CustomColor.danger,
            ),
          )
              : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout, size: 18, color: CustomColor.danger),
              const SizedBox(width: 8),
              const Text(
                'LOGOUT OF DRIVER ACCOUNT',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.danger,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/// Floating SOS button
class SosFab extends StatelessWidget {
  final VoidCallback onTap;
  const SosFab({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AppRoute.sos);
      },
      child: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColor.sosRed,
          boxShadow: [
            BoxShadow(
              color: CustomColor.sosRed.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'SOS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
/// Broadcast SOS Alert - hold to trigger button
class BroadcastSosButton extends StatelessWidget {
  final bool isBroadcasting;
  final VoidCallback onHoldComplete;

  const BroadcastSosButton({
    super.key,
    required this.isBroadcasting,
    required this.onHoldComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onLongPress: onHoldComplete,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [CustomColor.emergencyRedDark, CustomColor.emergencyRedLight],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: CustomColor.emergencyRedLight.withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: isBroadcasting
                ? const Center(
              child: SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: Colors.white,
                ),
              ),
            )
                : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.warning_amber_rounded,
                        color: Colors.white, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'BROADCAST SOS ALERT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'HOLD FOR 2 SECONDS TO DISPATCH',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.touch_app_outlined,
                size: 14, color: CustomColor.textSecondary(context)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Press and hold to prevent accidental false alarms over rough roads',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.5,
                  color: CustomColor.textSecondary(context),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Full-width primary action button (Depart / Notify).
class PrimaryActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color background;
  final VoidCallback onTap;

  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.background,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
// Bottom SOS floating action button.
class SosButton extends StatelessWidget {
  final VoidCallback onTap;
  const SosButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: CustomColor.sos,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: CustomColor.sos.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'SOS',
            style: TextStyle(
              color: CustomColor.onDark,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
/// One segment in the "Severity Level" selector.
class SeverityButton extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  const SeverityButton({
    super.key,
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? selectedColor
                : CustomColor.severityUnselectedBg(context),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? CustomColor.onDark
                      : CustomColor.severityUnselectedText(context),
                ),
              ),
              if (selected && subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.onDark,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

