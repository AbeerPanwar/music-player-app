import 'package:music_player/features/Auth/model/user_model.dart';
import 'package:music_player/features/Auth/view/pages/auth_page.dart';
import 'package:music_player/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';
import 'package:music_player/features/Home/view/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  final UserModel? currentUser;
  const SplashScreen({required this.currentUser, super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isDotCenter = false;
  bool _isScaleDot = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(microseconds: 400), () {
      setState(() {
        _isDotCenter = !_isDotCenter;
      });
    });
    Future.delayed(const Duration(milliseconds: 520), () {
      setState(() {
        _isScaleDot = !_isScaleDot;
        Future.delayed(const Duration(milliseconds: 540), () {
          setState(() {
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    widget.currentUser == null
                    ? const AuthScreen()
                    : const HomeScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeIn,
                          ),
                          child: child,
                        ),
              ),
              (_) => false,
            );
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Center(
              child: AnimatedScale(
                duration: const Duration(milliseconds: 600),
                curve: const Cubic(0.58, -0.3, 0.32, 1),
                scale: _isScaleDot ? 12 : 1,
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Pallete.gradient1,
                  child: _isScaleDot
                      ? null
                      : const Center(
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.black,
                          ),
                        ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: const Cubic(0.8, -1.2, 0.265, 1),
              left:
                  (MediaQuery.of(context).size.width / 2) -
                  12 -
                  (_isDotCenter ? 0 : 80),
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Pallete.gradient1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
