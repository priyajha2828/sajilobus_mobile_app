
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajilo_bus/pages/auth_pages/loginpage.dart';
import '../providers/splash_provider/splash_provider.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  @override

  void initState(){
    super.initState();

    Future.microtask(() async{
      final provider = Provider.of<SplashScreenProvider>(context, listen: false);

      await provider.startSplash();

      if(mounted){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginPage(),
          ),
        );
      }
    }
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Image.asset(
            'assets/images/fulllogo.png',
            width: 200,
          ),
        ),
      ),
    );
  }
}
