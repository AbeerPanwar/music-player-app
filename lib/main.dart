import 'package:client_/features/splashscreen/splash_screen.dart';
import 'package:client_/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nothing Music',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const SplashScreen(),
    );
  }
}
