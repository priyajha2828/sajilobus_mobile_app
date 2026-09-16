import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/driver_provider/history_provider.dart';
import '../../../resources/banner/driver_banner.dart';
import '../../../resources/bar/custom_bar.dart';
import '../../../resources/bottom/driver_button.dart';
import '../../../resources/card/custom_card.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/header/custom_header.dart';
import '../../../resources/widgets/driver_widgets.dart';


/// "Trip Manifest Detail" screen from FleetTrack.
///
/// NOTE: This screen intentionally does NOT include a bottomNavigationBar —
/// it is expected to be pushed/shown inside your own navigation shell
/// (the one with Dashboard / Trip / Notifications / Profile).
class TripManifestScreen extends StatelessWidget {
  const TripManifestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripManifestProvider(),
      child: const TripManifestBody(),
    );
  }
}

class TripManifestBody extends StatelessWidget {
  const TripManifestBody();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TripManifestProvider>();

    return Scaffold(
      backgroundColor: CustomColor.background(context),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            TopBar(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SearchFilterBar(
                            controller: provider.searchController,
                            hint: 'Search by Trip ID, date, or route...',
                            onChanged: (v) => context
                                .read<TripManifestProvider>()
                                .updateSearch(v),
                            onFilterTap: () => context
                                .read<TripManifestProvider>()
                                .openFilters(),
                          ),
                          const SizedBox(height: 12),
                          FilterTabsRow(provider: provider),
                          const SizedBox(height: 16),
                          StatsGrid(provider: provider),
                          const SizedBox(height: 20),
                          ManifestsHeader(provider: provider),
                          const SizedBox(height: 12),
                          DetailedManifestCard(
                            manifest: provider.featuredManifest,
                            onViewManifest: () => context
                                .read<TripManifestProvider>()
                                .viewManifest(provider.featuredManifest.tripId),
                            onShare: () => context
                                .read<TripManifestProvider>()
                                .shareManifest(provider.featuredManifest.tripId),
                          ),
                          const SizedBox(height: 14),
                          for (final m in provider.otherManifests) ...[
                            CompactManifestCard(
                              manifest: m,
                              onDetailsTap: () => context
                                  .read<TripManifestProvider>()
                                  .openDetails(m.tripId),
                            ),
                            const SizedBox(height: 14),
                          ],
                          DepartmentLogBanner(
                            title: provider.departmentTitle,
                            subtitle: provider.departmentSubtitle,
                            onTap: () => context
                                .read<TripManifestProvider>()
                                .openDepartmentLog(),
                          ),
                          const SizedBox(height: 12),
                          PrimaryActionButton(
                            label: provider.downloadButtonLabel,
                            icon: Icons.file_download_outlined,
                            background: CustomColor.primary,
                            onTap: () => context
                                .read<TripManifestProvider>()
                                .downloadMonthlyLog(),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              provider.footerNote,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: CustomColor.textMutedLabel(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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


