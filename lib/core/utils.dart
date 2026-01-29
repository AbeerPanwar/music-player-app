import 'package:flutter/material.dart';
import 'package:music_player/core/theme/app_pallet.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(color: Pallete.backgroundColor),
        ),
        backgroundColor: Pallete.geryGradiant2,
      ),
    );
}
