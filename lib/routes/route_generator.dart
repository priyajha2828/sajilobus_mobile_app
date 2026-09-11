import 'package:flutter/material.dart';
import 'package:sajilo_bus/pages/Driver_pages/StopManagement/stop_management_screen.dart';
import 'package:sajilo_bus/pages/Driver_pages/trip/trip_screen.dart';
import 'package:sajilo_bus/pages/Passenger_pages/passenger_dashboard/passenger_dashboard.dart';
import 'package:sajilo_bus/pages/auth_pages/loginpage.dart';

import '../pages/Driver_pages/driver_dashboard/driver_dashboard.dart';
import '../pages/Driver_pages/sos/sos_page.dart';
import '../pages/auth_pages/signup_page.dart';
import '../resources/navigation/driver_nav.dart';
import 'app_route.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case AppRoute.signuppage:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case AppRoute.loginpage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoute.p_dashboard:
        return MaterialPageRoute(builder: (_) => const PassengerDashboard());
      case AppRoute.d_dashboard:
        return MaterialPageRoute(builder: (_)=> const DashboardScreen());
      case AppRoute.d_navigation:
        return MaterialPageRoute(builder: (_)=> const BottomNavScreen());
      case AppRoute.stop_management:
        return MaterialPageRoute(builder: (_)=> const StopManagementScreen());
      case AppRoute.start_trip:
        return MaterialPageRoute(builder: (_)=> const TripScreen());
      case AppRoute.sos:
        return MaterialPageRoute(builder: (_)=> const EmergencyAssistanceScreen());
      default:
        return _errorRoute();
    }
  }
  static Route<dynamic>_errorRoute(){
    return MaterialPageRoute(builder: (_) => Scaffold(
      appBar: AppBar(title: const Text("Route Error")),
      body: const Center(child: Text("page not found")),
    ));
  }
}