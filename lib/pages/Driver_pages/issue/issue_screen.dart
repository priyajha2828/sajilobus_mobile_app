import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajilo_bus/routes/app_route.dart';

import '../../../providers/driver_provider/issue_provider.dart';
import '../../../resources/badge/badge.dart';
import '../../../resources/banner/driver_banner.dart';
import '../../../resources/bottom/driver_button.dart';
import '../../../resources/card/custom_card.dart';
import '../../../resources/chip/custom_chip.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/header/custom_header.dart';
import '../../../resources/tile/custom_tile.dart';
import '../../../resources/widgets/driver_widgets.dart';


/// "Report Operational Issue" screen from FleetTrack.
///
/// NOTE: This screen intentionally does NOT include a bottomNavigationBar —
/// it is expected to be pushed/shown inside your own navigation shell
/// (the one with Dashboard / Trip / Notifications / Profile).
class ReportIssueScreen extends StatelessWidget {
  const ReportIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportIssueProvider(),
      child: const _ReportIssueBody(),
    );
  }
}

class _ReportIssueBody extends StatelessWidget {
  const _ReportIssueBody();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReportIssueProvider>();

    return Scaffold(
      backgroundColor: CustomColor.background(context),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _TopBar()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _BackLink(label: provider.backLinkLabel),
                      const SizedBox(height: 12),
                      _DispatchLinkPill(label: provider.corridorLabel),
                      const SizedBox(height: 12),
                      Text(
                        provider.pageTitle,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: CustomColor.textPrimary(context),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        provider.pageSubtitle,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: CustomColor.textSecondary(context),
                        ),
                      ),
                      const SizedBox(height: 18),
                      _DiagnosticsCard(provider: provider),
                      const SizedBox(height: 20),
                      SectionHeader1(
                        title: 'Select Issue Category',
                        trailingText: 'Required *',
                        trailingColor: CustomColor.danger,
                      ),
                      const SizedBox(height: 10),
                      _CategoryGrid(provider: provider),
                      const SizedBox(height: 20),
                      SectionHeader1(
                        title: 'Severity Level',
                        trailingText: 'Affects schedule triage',
                      ),
                      const SizedBox(height: 10),
                      _SeverityRow(provider: provider),
                      const SizedBox(height: 20),
                      SectionHeader1(
                        title: 'Issue Description',
                        trailingText: 'Voice Record',
                        trailingIcon: Icons.mic_none_outlined,
                        trailingColor: CustomColor.chipText(context),
                        onTrailingTap: () => context
                            .read<ReportIssueProvider>()
                            .startVoiceRecording(),
                      ),
                      const SizedBox(height: 10),
                      DescriptionField(
                        controller: provider.descriptionController,
                        maxLength: provider.maxDescriptionChars,
                        isSynced: provider.isTelemetrySynced,
                        onChanged: (v) => context
                            .read<ReportIssueProvider>()
                            .updateDescription(v),
                      ),
                      const SizedBox(height: 20),
                      SectionHeader1(title: 'Attach Photographic Evidence'),
                      const SizedBox(height: 10),
                      _PhotoActionsRow(provider: provider),
                      const SizedBox(height: 12),
                      _PhotoStrip(provider: provider),
                      const SizedBox(height: 18),
                      WarningBanner1(text: provider.warningBannerText),
                      const SizedBox(height: 16),
                      PrimaryActionButton(
                        label: 'SUBMIT ISSUE TO DISPATCH',
                        icon: Icons.play_arrow_rounded,
                        background: CustomColor.primary,
                        onTap: () => context
                            .read<ReportIssueProvider>()
                            .submitIssueToDispatch(),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Immediate radio dispatch contact: ${provider.radioDispatchContact}',
                          style: TextStyle(
                            fontSize: 11,
                            color: CustomColor.textMutedLabel(context),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      _IncidentTrackingCard(provider: provider),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 24,
            child: SosButton(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.sos);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Top bar (dark navy header, matches the rest of the FleetTrack app)
// ---------------------------------------------------------------------
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.headerBg(context),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: CustomColor.onDarkTint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.local_shipping_outlined,
                color: CustomColor.onDark, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'FleetTrack',
                      style: TextStyle(
                        color: CustomColor.onDark,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: CustomColor.onlineDot,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'ONLINE',
                      style: TextStyle(
                        color: CustomColor.onlineDot,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Dashboard',
                  style: TextStyle(
                    color: CustomColor.onDarkMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 18,
            backgroundColor: CustomColor.onDarkFaint,
            child: Icon(Icons.person, color: CustomColor.onDark),
          ),
        ],
      ),
    );
  }
}

class _BackLink extends StatelessWidget {
  final String label;
  const _BackLink({required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).maybePop(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back, size: 16, color: CustomColor.textSecondary(context)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: CustomColor.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _DispatchLinkPill extends StatelessWidget {
  final String label;
  const _DispatchLinkPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: CustomColor.dispatchLinkBg(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: CustomColor.dispatchLinkText(context),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
              color: CustomColor.dispatchLinkText(context),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Auto-locked diagnostics card
// ---------------------------------------------------------------------
class _DiagnosticsCard extends StatelessWidget {
  final ReportIssueProvider provider;
  const _DiagnosticsCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield_outlined,
                  size: 18, color: CustomColor.iconMuted(context)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'AUTO-LOCKED DIAGNOSTICS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ),
              ),
              if (provider.isGpsLocked)
                InfoBadge(
                  label: 'GPS LOCKED',
                  icon: Icons.check_circle,
                  background: CustomColor.badgeGreenBg(context),
                  foreground: CustomColor.badgeGreenText(context),
                ),
            ],
          ),
          DiagnosticInfoRow(
            icon: Icons.directions_bus_outlined,
            label: 'VEHICLE ID',
            value: provider.vehicleId,
            trailingBadge: provider.busNumber,
          ),
          DiagnosticInfoRow(
            icon: Icons.alt_route,
            label: 'ASSIGNED TRANSIT ROUTE',
            value: '${provider.routeFrom} → ${provider.routeTo}',
            trailingBadge: provider.routeLine,
          ),
          DiagnosticInfoRow(
            icon: Icons.location_on_outlined,
            label: 'INCIDENT COORDINATES',
            value: provider.incidentCoordinates,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Issue category grid
// ---------------------------------------------------------------------
class _CategoryGrid extends StatelessWidget {
  final ReportIssueProvider provider;
  const _CategoryGrid({required this.provider});

  @override
  Widget build(BuildContext context) {
    final p = context.read<ReportIssueProvider>();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, index) {
        final item = provider.categories[index];
        return CategoryTile(
          icon: item.icon,
          label: item.label,
          selected: provider.selectedCategoryIndex == index,
          onTap: () => p.selectCategory(index),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------
// Severity level row
// ---------------------------------------------------------------------
class _SeverityRow extends StatelessWidget {
  final ReportIssueProvider provider;
  const _SeverityRow({required this.provider});

  Color _colorFor(int index) {
    switch (index) {
      case 0:
        return CustomColor.severityLow;
      case 1:
        return CustomColor.severityMedium;
      default:
        return CustomColor.severityCritical;
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.read<ReportIssueProvider>();
    return Row(
      children: [
        for (int i = 0; i < provider.severities.length; i++) ...[
          if (i != 0) const SizedBox(width: 10),
          SeverityButton(
            label: provider.severities[i].label,
            subtitle: provider.severities[i].subtitle,
            selected: provider.selectedSeverityIndex == i,
            selectedColor: _colorFor(i),
            onTap: () => p.selectSeverity(i),
          ),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------
// Photo evidence actions + strip
// ---------------------------------------------------------------------
class _PhotoActionsRow extends StatelessWidget {
  final ReportIssueProvider provider;
  const _PhotoActionsRow({required this.provider});

  @override
  Widget build(BuildContext context) {
    final p = context.read<ReportIssueProvider>();
    return Row(
      children: [
        Expanded(
          child: PrimaryActionButton(
            label: 'Take Photo',
            icon: Icons.camera_alt_outlined,
            background: CustomColor.primary,
            onTap: p.takePhoto,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 52,
            child: OutlinedButton.icon(
              onPressed: p.browseFiles,
              icon: Icon(Icons.folder_open_outlined,
                  size: 18, color: CustomColor.textPrimary(context)),
              label: Text(
                'Browse Files',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.textPrimary(context),
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: CustomColor.border(context)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PhotoStrip extends StatelessWidget {
  final ReportIssueProvider provider;
  const _PhotoStrip({required this.provider});

  @override
  Widget build(BuildContext context) {
    final p = context.read<ReportIssueProvider>();
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final photo in provider.photos)
          PhotoThumbnailTile(
            label: photo.label,
            onRemove: () => p.removePhoto(photo.id),
          ),
        AddPhotoTile(onTap: p.takePhoto),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// Incident tracking card
// ---------------------------------------------------------------------
class _IncidentTrackingCard extends StatelessWidget {
  final ReportIssueProvider provider;
  const _IncidentTrackingCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                provider.reportId,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: CustomColor.textPrimary(context),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: CustomColor.onlineDot,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  provider.loggedAgo,
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ),
              TagChip(
                label: provider.severityBadge,
                background: CustomColor.warningBannerBg(context),
                foreground: CustomColor.danger,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            provider.issueTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: CustomColor.textPrimary(context),
            ),
          ),
          const SizedBox(height: 18),
          IncidentStepper(currentStage: provider.currentStage),
          const SizedBox(height: 18),
          DispatchMessageCard(
            author: provider.opsAuthor,
            message: provider.opsMessage,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => context
                  .read<ReportIssueProvider>()
                  .callDispatchContact(),
              icon: Icon(Icons.call_outlined,
                  size: 16, color: CustomColor.primary),
              label: Text(
                'Call ${provider.dispatchContactName} (Direct Line)',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.primary,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: CustomColor.border(context)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}