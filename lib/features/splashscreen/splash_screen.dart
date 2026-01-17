import 'package:client_/features/Auth/view/pages/auth_page.dart';
import 'package:client_/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isDotCenter = false;
  bool _isScaleDot = false;

  @override
  void initState() {
    Future.delayed(Duration(microseconds: 200), () {
      setState(() {
        _isDotCenter = !_isDotCenter;
      });
    });
    Future.delayed(Duration(milliseconds: 520), () {
      setState(() {
        _isScaleDot = !_isScaleDot;
        Future.delayed(Duration(milliseconds: 600), () {
          setState(() {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AuthScreen(),
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
                duration: Duration(milliseconds: 600),
                curve: Cubic(0.58, -0.3, 0.32, 1),
                scale: _isScaleDot ? 12 : 1,
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Pallete.gradient1,
                  child: _isScaleDot
                      ? null
                      : Center(
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.black,
                          ),
                        ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Cubic(0.68, -1.2, 0.265, 1),
              left:
                  (MediaQuery.of(context).size.width / 2) -
                  12 -
                  (_isDotCenter ? 0 : 80),
              child: CircleAvatar(radius: 12, backgroundColor: Pallete.gradient1),
            ),
          ],
        ),
      ),
    );
  }
}
