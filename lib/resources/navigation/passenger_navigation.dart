import 'package:flutter/material.dart';

import '../../pages/Passenger_pages/passenger_dashboard/passenger_dashboard.dart';
import '../color/custom_color.dart';


class UserNavScreen extends StatefulWidget {
  const UserNavScreen({super.key});

  @override
  State<UserNavScreen> createState() =>
      _UserNavScreen();
}

class _UserNavScreen
    extends State<UserNavScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const TransitHomeScreen(),
    // const TripScreen(),
    // const NotificationsScreen(),
    // const DriverProfileScreen(),
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