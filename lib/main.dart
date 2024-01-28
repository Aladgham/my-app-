import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/item_screen_provider.dart';
import 'providers/main_screen_provider.dart';
import 'providers/profile_screen_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MainScreenProvider()),
      ChangeNotifierProvider(create: (_) => ItemsScreenProvider()),
      ChangeNotifierProvider(create: (_) => ProfileScreenProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const SplashScreen(),
    );
  }
}
