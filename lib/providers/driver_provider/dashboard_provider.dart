import 'package:flutter/material.dart';

class DriverDashboardProvider extends ChangeNotifier {
  bool driverOnline = true;

  void toggleDriverState() {
    driverOnline = !driverOnline;
    notifyListeners();
  }
}