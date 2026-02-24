import 'package:flutter/material.dart';
import 'package:music_player/core/theme/app_pallet.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          color: Pallete.cardColor,
        ),
        child: const Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Feature Comming Soon...',
            style: TextStyle(
              fontFamily: 'Zain',
              color: Pallete.gradient1,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
