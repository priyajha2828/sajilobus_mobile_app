import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajilo_bus/providers/auth_provider/auth_provider.dart';
import 'package:sajilo_bus/providers/splash_provider/splash_provider.dart';
import 'package:sajilo_bus/routes/app_route.dart';
import 'package:sajilo_bus/routes/route_generator.dart';
import 'package:sajilo_bus/screen/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      onGenerateRoute: RouteGenerator.generateRoutes,

    );
  }
}