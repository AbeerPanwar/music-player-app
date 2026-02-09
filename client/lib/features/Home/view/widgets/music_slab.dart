import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/core/providers/current_song_notifier.dart';
import 'package:music_player/core/theme/app_pallet.dart';
import 'package:music_player/core/utils.dart';
import 'package:music_player/features/Home/view/widgets/music_player.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);

    if (currentSong == null) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        showGeneralDialog(
          context: context,
          transitionDuration: const Duration(milliseconds: 250),
          pageBuilder: (context, animation, secondaryAnimation) {
            return const MusicPlayer();
          },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            final slideAnimation =
                Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                    reverseCurve: Curves.easeInCubic,
                  ),
                );

            return SlideTransition(
              position: slideAnimation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lighten(hexToColor(currentSong.hex_code), 0.2),
                    darken(hexToColor(currentSong.hex_code), 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              height: 66,
              width: MediaQuery.of(context).size.width - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Hero(
                        tag: 'music-thumbnail',
                        child: Container(
                          width: 48,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(currentSong.thumbnail_url),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentSong.song_name,
                            style: TextStyle(
                              fontFamily: 'Zain',
                              fontSize: 16,
                              color: darken(
                                hexToColor(currentSong.hex_code),
                                0.8,
                              ),
                            ),
                          ),
                          Text(
                            currentSong.artist,
                            style: TextStyle(
                              fontFamily: 'Zain',
                              fontSize: 14,
                              color: darken(
                                hexToColor(currentSong.hex_code),
                                0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.heart,
                          color: Pallete.whiteColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          songNotifier.playAndPause();
                        },
                        icon: Icon(
                          songNotifier.isPlaying
                              ? CupertinoIcons.pause_fill
                              : CupertinoIcons.play_fill,
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: songNotifier.audioPlayer?.positionStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                final position = snapshot.data;
                final duration = songNotifier.audioPlayer!.duration;

                double sliderValue = 0.0;
                if (position != null && duration != null) {
                  sliderValue =
                      position.inMilliseconds / duration.inMilliseconds;
                }
                return Positioned(
                  bottom: 0,
                  left: 12,
                  child: Container(
                    height: 2,
                    width:
                        sliderValue * (MediaQuery.of(context).size.width - 38),
                    decoration: BoxDecoration(
                      color: Pallete.whiteColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 12,
              child: Container(
                height: 2,
                width: MediaQuery.of(context).size.width - 38,
                decoration: BoxDecoration(
                  color: Pallete.inactiveSeekColor,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
