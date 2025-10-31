import 'package:client_/features/Auth/view/pages/auth_page.dart';
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
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const AuthScreen(),
    );
  }
}
