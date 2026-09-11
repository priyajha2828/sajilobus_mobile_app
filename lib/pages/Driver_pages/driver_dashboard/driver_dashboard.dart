import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajilo_bus/resources/color/custom_color.dart';
import 'package:sajilo_bus/routes/app_route.dart';

import '../../../providers/driver_provider/dashboard_provider.dart';
import '../../../providers/theme/theme_provider.dart';
import '../../../resources/card/driver_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool driverOnline = true;
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Kept for future wiring to real backend data.
    // final provider = context.watch<DriverDashboardProvider>();

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- TOP APP BAR ----------------
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CustomColor.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.directions_bus,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "SajiloBus",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: CustomColor.textPrimary(context),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.circle,
                                      size: 8, color: Colors.green),
                                  SizedBox(width: 4),
                                  Text(
                                    "ONLINE",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Dashboard",
                          style: TextStyle(
                            color: CustomColor.textSecondary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return IconButton(
                        onPressed: () {
                          themeProvider.toggleTheme();
                        },
                        icon: Icon(
                          themeProvider.isDark
                              ? Icons.light_mode_rounded
                              : Icons.dark_mode_rounded,
                          color: CustomColor.textPrimary(context),
                        ),
                      );
                    },
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/32.jpg",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ---------------- NOTICE BANNER ----------------
              const NoticeBanner(
                title: "Koshi Corridor Alert:",
                message:
                "Notice: Koshi Highway road expansion near Duhabi — expect ~10 min slow crawl.",
              ),

              const SizedBox(height: 16),

              // ---------------- DRIVER PROFILE CARD ----------------
              const DriverProfileCard(
                driverName: "Ram Kumar Yadav",
                driverCode: "DRV-001",
                photoUrl: "https://randomuser.me/api/portraits/men/45.jpg",
                rating: 4.8,
                totalTrips: 1200,
                licenseNo: "KOSHI-2025-45879",
                busName: "BUS-101 (Deluxe Coach)",
                plateNumber: "BA 2 KHA 4567",
                seatInfo: "40-Seater • Air Suspended",
                inService: true,
                corridorLabel: "Assigned Corridor",
                corridorRoute:
                "Biratnagar Bus Park → Itahari (Koshi Highway)",
                shiftTime: "07:00 AM – 03:00 PM",
                shiftLabel: "Shift 1",
                remainingTime: "5h 22m",
              ),

              const SizedBox(height: 16),

              // ---------------- STATUS TOGGLES ----------------
              Row(
                children: [
                  Expanded(
                    child: ToggleStatusCard(
                      title: "BUS STATUS",
                      value: "ACTIVE",
                      subtitle: "Live tracking active",
                      footerIcon: Icons.satellite_alt,
                      footerText: "12 Sats Locked • 4G",
                      isOn: true,
                      onChanged: (_) {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ToggleStatusCard(
                      title: "DRIVER STATE",
                      value: "ONLINE",
                      subtitle: "Ready for dispatch",
                      footerIcon: Icons.check_circle,
                      footerText: "Auto-dispatch ON",
                      isOn: driverOnline,
                      onChanged: (v) => setState(() => driverOnline = v),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ---------------- OCCUPANCY / SPEED ----------------
              Row(
                children: const [
                  Expanded(
                    child: OccupancyCard(
                      occupied: 32,
                      capacity: 40,
                      note: "80% Loaded",
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: LiveSpeedCard(
                      speed: 42,
                      direction: "North",
                      location: "Mahendra Chowk, Biratnagar Urban Sector",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ---------------- ACTIVE TRIP CARD ----------------
              ActiveTripCard(
                tripId: "882",
                stopName: "Duhabi Bazar Halt",
                eta: "09:54 AM",
                distanceRemaining: "3.2 km",
                onViewMap: () {},
                onTripEnd: () {},
              ),

              const SizedBox(height: 24),

              // ---------------- TRANSIT COMMAND ----------------
              Row(
                children: [
                  Text(
                    "Transit Command",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "6 Shortcuts",
                    style: TextStyle(
                      fontSize: 12,
                      color: CustomColor.textSecondary(context),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: .95,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  CommandCard(
                    icon: Icons.play_arrow,
                    title: "Start Trip",
                    iconColor: Colors.green,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.start_trip);
                    },
                  ),
                  CommandCard(
                    icon: Icons.stop,
                    title: "End Trip",
                    iconColor: Colors.orange,
                    onTap: () {},
                  ),
                  CommandCard(
                    icon: Icons.location_on,
                    title: "Stops Hub",
                    iconColor: Colors.blue,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.stop_management);
                    },
                  ),
                  CommandCard(
                    icon: Icons.sos,
                    title: "SOS Alert",
                    iconColor: Colors.red,
                    onTap: () {},
                  ),
                  CommandCard(
                    icon: Icons.build,
                    title: "Report Issue",
                    iconColor: Colors.deepOrange,
                    onTap: () {},
                  ),
                  CommandCard(
                    icon: Icons.history,
                    title: "Trip Logs",
                    iconColor: Colors.blueGrey,
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ---------------- CORRIDOR MAP ----------------
              CorridorMapCard(
                title: "Koshi Corridor Elevation & Traffic",
                trafficStatus: "Smooth Flow",
                liveLagText: "0.8s lag",
                totalDistanceText: "Brt → Ith: 24.8 km total",
                stops: const [
                  RouteStopPoint(
                    name: "Biratnagar Terminal",
                    time: "09:15",
                    icon: Icons.circle,
                    color: Colors.blue,
                  ),
                  RouteStopPoint(
                    name: "Duhabi",
                    time: "09:54",
                    icon: Icons.location_on,
                    color: Colors.orange,
                  ),
                  RouteStopPoint(
                    name: "Itahari",
                    time: "10:30",
                    icon: Icons.flag,
                    color: Colors.green,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ---------------- TICKETING SYNC ----------------
              TicketingSyncCard(
                title: "Digital Ticketing Sync",
                eTickets: 28,
                cashBoardings: 4,
                onManifest: () {},
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.sos);
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber_rounded, size: 18, color: Colors.white),
            Text(
              "SOS",
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),


    );
  }
}