import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:music_player/core/providers/current_user_notifier.dart';
import 'package:music_player/core/theme/app_pallet.dart';
import 'package:music_player/core/utils.dart';
import 'package:music_player/features/Home/view/pages/upload_song_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currnetUser = ref.watch(currentUserNotifierProvider);
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: lighten(Pallete.gradient2, 0.2),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      currnetUser!.name.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        color: darken(Pallete.gradient1, 0.2),
                        fontFamily: 'Zain',
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            LiquidGlassLayer(
              child: LiquidStretch(
                child: LiquidGlass(
                  shape: const LiquidRoundedSuperellipse(borderRadius: 25),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: IconButton(
                      onPressed: () async {
                        HapticFeedback.lightImpact();
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const UploadSongPage(),
                          ),
                        );
                      },
                      icon: const Text(
                        'Upload Song',
                        style: TextStyle(fontFamily: 'Zain'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
