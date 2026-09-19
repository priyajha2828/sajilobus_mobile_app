import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:sajilo_bus/routes/app_route.dart';

import '../../../providers/passenger_provider/live_track_provider.dart';
import '../../../providers/passenger_provider/profile_provider.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/widgets/live_track_widgets.dart';

/// =========================================================
/// LIVE VEHICLE TRACKER SCREEN
/// Map fills the background, a draggable sheet sits on top.
/// No bottom navigation bar here.
/// =========================================================
class LiveTrackScreen extends StatelessWidget {
  const LiveTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final track = context.watch<LiveTrackProvider>();
    final profileProvider = context.watch<ProfileProvider>();

    return Scaffold(
      backgroundColor: CustomColor.background(context),

      appBar: LiveTrackAppBar(
        title: track.screenTitle,
        avatarUrl: track.avatarUrl,
        localPhotoFile: profileProvider.localPhotoFile,
        onBack: () => track.goBack(context),
        onAvatarTap: track.openProfile,
      ),

      body: Stack(
        children: [
          // ---------------- MAP ----------------
          Positioned.fill(
            child: _MapArea(track: track),
          ),

          // ---------------- BOTTOM SHEET ----------------
          DraggableScrollableSheet(
            initialChildSize: .62,
            minChildSize: .42,
            maxChildSize: .92,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: CustomColor.card(context),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.10),
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  children: [
                    const SheetGrabHandle(),

                    const SizedBox(height: 6),

                    // ---- Vehicle header ----
                    VehicleHeaderRow(
                      busNumber: track.busNumber,
                      serviceType: track.serviceType,
                      statusLabel: track.statusLabel,
                      subtitle: track.vehicleSubtitle,
                    ),

                    const SizedBox(height: 16),

                    // ---- 2x2 metrics ----
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 1.32,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        LiveMetricCard(
                          title: "ARRIVAL IN",
                          icon: Icons.access_time,
                          value: track.arrivalValue,
                          valueColor: CustomColor.accentBlue1,
                          subtitle: track.arrivalSubtitle,
                        ),
                        LiveMetricCard(
                          title: "DISTANCE",
                          icon: Icons.location_on_outlined,
                          value: track.distanceValue,
                          subtitle: track.speedSubtitle,
                        ),
                        LiveMetricCard(
                          title: "CROWD",
                          icon: Icons.people_outline,
                          value: "${track.occupiedSeats}",
                          valueSuffix: " / ${track.totalSeats} seats",
                          subtitle: "",
                          progress: track.crowdRatio,
                        ),
                        NextStopCard(
                          stopName: track.nextStopName,
                          status: track.nextStopStatus,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ---- Route milestones ----
                    RouteMilestonesCard(
                      title: track.milestonesTitle,
                      trailing: track.stopsRemaining,
                      milestones: track.milestones,
                    ),

                    const SizedBox(height: 16),

                    // ---- Actions ----
                    Row(
                      children: [
                        Expanded(
                          child: LiveActionButton(
                            icon: Icons.notifications_active_outlined,
                            label: "Alert",
                            background: CustomColor.buttonSoft(context),
                            foreground: CustomColor.accentBlue1,
                            onTap: track.setAlert,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: LiveActionButton(
                            icon: Icons.my_location,
                            label: "Share",
                            background: CustomColor.buttonSoft(context),
                            foreground: CustomColor.accentBlue1,
                            onTap: track.shareTrip,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: LiveActionButton(
                            icon: Icons.power_settings_new,
                            label: "SOS",
                            background: CustomColor.danger,
                            foreground: Colors.white,
                            onTap: (){
                              Navigator.pushNamed(context, AppRoute.p_sos);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// =========================================================
/// MAP AREA — placeholder map + all floating overlays
/// =========================================================
class _MapArea extends StatelessWidget {
  final LiveTrackProvider track;

  const _MapArea({required this.track});

  @override
  Widget build(BuildContext context) {
    final busLoc = track.busLocation;
    final passLoc = track.passengerLocation;

    return Stack(
      children: [
        // ---- Interactive Vector Map (OpenStreetMap) ----
        Positioned.fill(
          child: FlutterMap(
            options: MapOptions(
              initialCenter: busLoc,
              initialZoom: 13.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'np.sajilobus.app',
              ),
              MarkerLayer(
                markers: [
                  // Passenger Marker
                  Marker(
                    point: passLoc,
                    width: 60,
                    height: 60,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F766E),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "You",
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(
                          Icons.person_pin_circle,
                          color: Color(0xFF0F766E),
                          size: 26,
                        ),
                      ],
                    ),
                  ),

                  // Live Bus Marker
                  Marker(
                    point: busLoc,
                    width: 80,
                    height: 60,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F2937),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            track.busPlateChip,
                            style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: CustomColor.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 4),
                            ],
                          ),
                          child: const Icon(
                            Icons.directions_bus_filled,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ---- Top overlay row ----
        Positioned(
          top: 12,
          left: 12,
          right: 12,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 6,
                child: RouteOverlayPill(
                  routeNumber: track.routeNumber,
                  from: track.routeFrom,
                  to: track.routeTo,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                flex: 5,
                child: GpsStatusPill(text: track.gpsStatus),
              ),
            ],
          ),
        ),

        // ---- Map controls ----
        Positioned(
          right: 14,
          top: 80,
          child: Column(
            children: [
              MapSquareButton(
                icon: Icons.my_location,
                onTap: track.recenterMap,
              ),
              const SizedBox(height: 12),
              MapSquareButton(
                icon: Icons.layers_outlined,
                onTap: track.toggleMapLayer,
              ),
            ],
          ),
        ),
      ],
    );
  }
}