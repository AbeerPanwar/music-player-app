import 'package:flutter/material.dart';
import 'package:music_player/core/theme/app_pallet.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: Pallete.gradient1,));
  }
}
