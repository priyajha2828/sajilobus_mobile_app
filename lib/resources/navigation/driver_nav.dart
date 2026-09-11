import 'package:flutter/material.dart';

import '../../pages/Driver_pages/driver_dashboard/driver_dashboard.dart';
import '../../pages/Driver_pages/notifications/notification_screen.dart';
import '../../pages/Driver_pages/profile/profile_screen.dart';
import '../../pages/Driver_pages/trip/trip_screen.dart';
import '../color/custom_color.dart';


class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() =>
      _BottomNavScreenState();
}

class _BottomNavScreenState
    extends State<BottomNavScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const DashboardScreen(),
    const TripScreen(),
    const NotificationsScreen(),
     const DriverProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[currentIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle:
            WidgetStateProperty.resolveWith<TextStyle>((states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                );
              }
              return const TextStyle(
                color: Colors.grey,
              );
            }),
          ),
          child: NavigationBar(
            backgroundColor: CustomColor.nav(context),
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined,color: Colors.white),
                selectedIcon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: Icon(Icons.route_outlined,color: Colors.white,),
                selectedIcon: Icon(Icons.route),
                label: 'Trip',
              ),
              NavigationDestination(
                icon: Icon(Icons.notifications_outlined,color: Colors.white),
                selectedIcon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline,color: Colors.white),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),

        )
    );
  }
}