import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajilo_bus/providers/passenger_provider/trip_history_provider.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/widgets/trip_history_widgets.dart';

/// =========================================================
/// TRACK SCREEN (Passenger)
/// Trip history + weekly commute summary.
/// No bottom navigation bar here — the parent shell provides it.
/// =========================================================
class P_TripHistoryScreen extends StatelessWidget {
  const P_TripHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final track = context.watch<P_TripHistoryProvider>();
    final trip = track.yesterdayTrip;

    return Scaffold(
      backgroundColor: CustomColor.background(context),

      appBar: TrackAppBar(
        brandName: track.brandName,
        title: track.screenTitle,
        unreadCount: track.unreadAlerts,
        avatarUrl: track.avatarUrl,
        onBellTap: track.openNotifications,
        onAvatarTap: track.openProfile,
      ),

      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // ---------- Search ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TrackSearchField(
                  controller: track.searchController,
                  hint: "Search past routes, bus numbers, stops",
                  onChanged: track.onSearchChanged,
                  onFilterTap: track.openFilterSheet,
                ),
              ),

              const SizedBox(height: 16),

              // ---------- Filter chips ----------
              TrackFilterChips(
                filters: track.filters,
                selectedIndex: track.selectedFilter,
                onSelected: track.selectFilter,
              ),

              const SizedBox(height: 16),

              // ---------- Commute summary ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CommuteSummaryCard(
                  label: track.summaryLabel,
                  title: track.summaryTitle,
                  co2Text: track.co2Saved,
                  totalTrips: track.totalTrips,
                  totalTripsDelta: track.totalTripsDelta,
                  distance: track.totalDistance,
                  distanceUnit: track.totalDistanceUnit,
                  avgCommute: track.avgCommute,
                  avgCommuteUnit: track.avgCommuteUnit,
                ),
              ),

              const SizedBox(height: 20),

              // ---------- Yesterday section ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TrackSectionHeader(
                  label: track.yesterdayLabel,
                  trailing: track.yesterdayTrailing,
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TripHistoryCard(
                  routeName: trip.routeName,
                  timeRange: trip.timeRange,
                  verifiedTicket: trip.verifiedTicket,
                  boardingStop: trip.boardingStop,
                  boardingNote: trip.boardingNote,
                  dropStop: trip.dropStop,
                  dropNote: trip.dropNote,
                  distance: trip.distance,
                  duration: trip.duration,
                  avgSpeed: trip.avgSpeed,
                  busPlate: trip.busPlate,
                  busName: trip.busName,
                  fare: trip.fare,
                  paymentMethod: trip.paymentMethod,
                  stopCount: trip.stopCount,
                  scheduleStatus: trip.scheduleStatus,
                  stopsEnRoute: trip.stopsEnRoute,
                  // mapWidget: GoogleMap(...),  <- plug your map in here
                  onExpandMap: () => track.expandMap(trip),
                  onViewReceipt: () => track.viewReceipt(trip),
                  onBookAgain: () => track.bookAgain(trip),
                ),
              ),

              const SizedBox(height: 22),

              // ---------- Earlier this week ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TrackSectionHeader(
                  label: track.earlierLabel,
                  trailing: track.earlierTrailing,
                  trailingColor: CustomColor.textSecondary(context),
                ),
              ),

              const SizedBox(height: 12),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: track.earlierTrips.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = track.earlierTrips[index];
                  return CompactTripTile(
                    routeName: item.routeName,
                    dateTime: item.dateTime,
                    fare: item.fare,
                    from: item.from,
                    to: item.to,
                    distance: item.distance,
                    duration: item.duration,
                    plate: item.plate,
                    onTap: () => track.openTripDetail(item),
                  );
                },
              ),

              const SizedBox(height: 18),

              // ---------- Reward banner ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RiderRewardBanner(
                  title: track.rewardTitle,
                  subtitle: track.rewardSubtitle,
                  onTap: track.openRewards,
                ),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}