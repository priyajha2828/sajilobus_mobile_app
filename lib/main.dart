import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajilo_bus/providers/splash_provider/splash_provider.dart';
import 'package:sajilo_bus/screen/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SplashScreenProvider(),
        ),
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

    );
  }
}