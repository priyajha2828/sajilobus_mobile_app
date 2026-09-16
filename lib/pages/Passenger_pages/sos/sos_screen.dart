import 'package:flutter/material.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/widgets/p_sos_widgets.dart';


/// Live Vehicle Tracker → Emergency / SOS screen.
///
/// This widget renders ONLY the screen body. The top app bar
/// ("Live Vehicle Tracker" + back arrow + avatar) and the bottom
/// navigation bar are expected to be supplied by the parent/host
/// screen that navigates to this widget.
///
/// Wrap this widget (or the host Scaffold) with:
///
/// ChangeNotifierProvider(
///   create: (_) => EmergencyProvider(),
///   child: const EmergencySosScreen(),
/// )
class EmergencySosScreen extends StatelessWidget {
  const EmergencySosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.bg_color(context),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top emergency banner
              const EmergencyBannerTile(),
              const SizedBox(height: 16),

              // Telemetry lock + GPS + vehicle info card
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TelemetryLockTile(),
                    const SizedBox(height: 12),
                    const GpsCoordinatesTile(),
                    const SizedBox(height: 12),
                    const VehicleInfoTile(),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Live dispatch lifecycle
              SectionCard(child: const DispatchLifecycleTile()),
              const SizedBox(height: 16),

              // Nature of emergency
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SectionHeader(title: 'Nature of Emergency', actionLabel: 'Select one or more'),
                    SizedBox(height: 12),
                    EmergencyTypeGrid(),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Incident details
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Incident Details (Optional)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: CustomColor.textPrimary(context),
                          ),
                        ),
                        Text(
                          'Voice or text',
                          style: TextStyle(fontSize: 11.5, color: CustomColor.textMutedLabel(context)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const IncidentDetailsField(),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Critical response initiator (SOS)
              SectionCard(
                padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 16, color: CustomColor.danger),
                        const SizedBox(width: 6),
                        Text(
                          'CRITICAL RESPONSE INITIATOR',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.4,
                            color: CustomColor.danger,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const SosHoldButton(),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: SosDescriptionText(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Quick call buttons
              Row(
                children: [
                  Expanded(
                    child: QuickCallButton(
                      icon: Icons.call,
                      title: 'Call 100',
                      subtitle: 'Nepal Police Hot-Line',
                      background: CustomColor.callPoliceBg(context),
                      onTap: () {
                        // TODO: hook up url_launcher: tel:100
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: QuickCallButton(
                      icon: Icons.traffic,
                      title: 'Call 103',
                      subtitle: 'Traffic Police Ops',
                      background: CustomColor.callTrafficBg(context),
                      onTap: () {
                        // TODO: hook up url_launcher: tel:103
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Central transit dispatch preview
              const DispatchPreviewCard(),
              const SizedBox(height: 8),

              // Safe return footer
              SafeReturnFooter(
                onTap: () => Navigator.of(context).maybePop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}