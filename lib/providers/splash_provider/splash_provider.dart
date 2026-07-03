import 'package:flutter/material.dart';

class SplashScreenProvider extends ChangeNotifier{

  bool _isLoading = true;

  bool get isLoading =>_isLoading;

  Future<void> startSplash() async{
    await Future.delayed(const Duration(seconds :10));

    _isLoading = false;
    notifyListeners();
  }
}