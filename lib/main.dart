import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajilo_bus/providers/auth_provider/auth_provider.dart';
import 'package:sajilo_bus/providers/driver_provider/dashboard_provider.dart';
import 'package:sajilo_bus/providers/driver_provider/history_provider.dart';
import 'package:sajilo_bus/providers/driver_provider/issue_provider.dart';
import 'package:sajilo_bus/providers/driver_provider/notifications_provider.dart';
import 'package:sajilo_bus/providers/driver_provider/profile_provider.dart';
import 'package:sajilo_bus/providers/driver_provider/sos_provider.dart';
import 'package:sajilo_bus/providers/driver_provider/stop_management_provider.dart';
import 'package:sajilo_bus/providers/driver_provider/trip_provider.dart';
import 'package:sajilo_bus/providers/passenger_provider/dashboard_provider.dart';
import 'package:sajilo_bus/providers/splash_provider/splash_provider.dart';
import 'package:sajilo_bus/providers/theme/theme_provider.dart';
import 'package:sajilo_bus/routes/route_generator.dart';
import 'package:sajilo_bus/screen/splash_screen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("firebase connected successfully");
  print(Firebase.apps);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_)=> DriverDashboardProvider()),
        ChangeNotifierProvider(create: (_)=>TripProvider() ),
        ChangeNotifierProvider(create: (_)=> StopManagementProvider()),
        ChangeNotifierProvider(create: (_)=> ThemeProvider()),
        ChangeNotifierProvider(create: (_)=> NotificationsProvider()),
        ChangeNotifierProvider(create: (_)=> DriverProfileProvider()),
        ChangeNotifierProvider(create: (_)=>EmergencyProvider()),
        ChangeNotifierProvider(create: (_)=> ReportIssueProvider()),
        ChangeNotifierProvider(create: (_)=> TripManifestProvider()),
        ChangeNotifierProvider(create: (_)=> TransitHomeProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder:(context,themeProvider,child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const SplashScreen(),
          onGenerateRoute: RouteGenerator.generateRoutes,

        );
      }
    );
  }
}