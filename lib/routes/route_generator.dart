import 'package:flutter/material.dart';
import 'package:sajilo_bus/pages/auth_pages/loginpage.dart';

import '../pages/auth_pages/signup_page.dart';
import 'app_route.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case AppRoute.signuppage:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case AppRoute.loginpage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
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