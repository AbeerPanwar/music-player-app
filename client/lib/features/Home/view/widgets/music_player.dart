import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:music_player/core/providers/current_song_notifier.dart';
import 'package:music_player/core/providers/current_user_notifier.dart';
import 'package:music_player/core/theme/app_pallet.dart';
import 'package:music_player/core/utils.dart';
import 'package:music_player/features/Home/viewmodel/home_viewmodel.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.watch(currentSongNotifierProvider.notifier);
    final favorites = ref.watch(
      currentUserNotifierProvider.select((data) => data!.favorites),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
          colors: [hexToColor(currentSong!.hex_code), const Color(0xff121212)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Pallete.transparentColor,
        appBar: AppBar(
          backgroundColor: Pallete.transparentColor,
          leading: Transform.translate(
            offset: const Offset(-10, 0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                onPressed: () {
                  HapticFeedback.selectionClick();
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Pallete.whiteColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: 'music-thumbnail',
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(currentSong.thumbnail_url),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentSong.song_name,
                            style: const TextStyle(
                              fontFamily: 'Zain',
                              fontSize: 24,
                              color: Pallete.whiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            currentSong.artist,
                            style: const TextStyle(
                              fontFamily: 'Zain',
                              fontSize: 16,
                              color: Pallete.subtitleText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () async {
                          HapticFeedback.selectionClick();
                          await ref
                              .read(homeViewModelProvider.notifier)
                              .favoriteSong(songId: currentSong.id);
                        },
                        icon:
                            favorites
                                .where((fav) => fav.song_id == currentSong.id)
                                .toList()
                                .isNotEmpty
                            ? const Icon(
                                CupertinoIcons.heart_fill,
                                color: Pallete.whiteColor,
                              )
                            : const Icon(
                                CupertinoIcons.heart,
                                color: Pallete.whiteColor,
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  StreamBuilder(
                    stream: songNotifier.audioPlayer!.positionStream,
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
                      return Column(
                        children: [
                          StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                                  return SliderTheme(
                                    data: SliderThemeData(
                                      activeTrackColor: Pallete.whiteColor,
                                      inactiveTrackColor: Pallete.geryGradiant3,
                                      thumbColor: Pallete.whiteColor,
                                      overlayShape:
                                          SliderComponentShape.noOverlay,
                                      trackHeight: 4,
                                    ),
                                    child: Slider(
                                      value: sliderValue,
                                      onChanged: (val) {
                                        HapticFeedback.selectionClick();
                                        setState(() => sliderValue = val);
                                      },
                                      onChangeEnd: (value) {
                                        HapticFeedback.selectionClick();
                                        songNotifier.seek(value);
                                      },
                                    ),
                                  );
                                },
                          ),
                          Row(
                            children: [
                              Text(
                                '${position?.inMinutes} : ${(position?.inSeconds)! % 60 < 10 ? '0${(position?.inSeconds)! % 60}' : (position?.inSeconds)! % 60}',
                                style: const TextStyle(
                                  fontFamily: 'Zain',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Pallete.subtitleText,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Text(
                                '${duration?.inMinutes} : ${(duration?.inSeconds)! % 60 < 10 ? '0${(duration?.inSeconds)! % 60}' : (duration?.inSeconds)! % 60}',
                                style: const TextStyle(
                                  fontFamily: 'Zain',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Pallete.subtitleText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        CupertinoIcons.shuffle,
                        color: Pallete.whiteColor,
                        size: 20,
                      ),
                      const Icon(Icons.skip_previous_rounded, size: 50),
                      LiquidGlassLayer(
                        child: LiquidStretch(
                          child: LiquidGlass(
                            shape: const LiquidRoundedSuperellipse(
                              borderRadius: 40,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: IconButton(
                                onPressed: () {
                                  HapticFeedback.lightImpact();
                                  songNotifier.playAndPause();
                                },
                                icon: Icon(
                                  songNotifier.isPlaying
                                      ? CupertinoIcons.pause_fill
                                      : CupertinoIcons.play_fill,
                                  size: 40,
                                  color: Pallete.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Icon(Icons.skip_next_rounded, size: 50),
                      const Icon(
                        CupertinoIcons.repeat,
                        color: Pallete.whiteColor,
                        size: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.devices,
                          color: Pallete.whiteColor,
                          size: 20,
                        ),
                        Icon(
                          Icons.playlist_add,
                          color: Pallete.whiteColor,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
