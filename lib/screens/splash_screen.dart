import 'package:e_commarce/screens/login.dart';
import 'package:e_commarce/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  String email = '';

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 200,
      centered: true,
      splash: 'assets/images/splash.jpg',
      nextScreen: !isLoggedIn ? const LoginPage() : const MainScreen(),
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 3),
    );
  }

  autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userPhone = prefs.getString('phone');
    if (userPhone != "" && userPhone != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }
}
