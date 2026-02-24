import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:music_player/core/providers/current_song_notifier.dart';
import 'package:music_player/core/theme/app_pallet.dart';
import 'package:music_player/core/widgets/loader.dart';
import 'package:music_player/features/Home/view/pages/upload_song_page.dart';
import 'package:music_player/features/Home/viewmodel/home_viewmodel.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(getFavSongsProvider)
        .when(
          data: (data) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          'My Library',
                          style: TextStyle(
                            fontFamily: 'Zain',
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const IconButton(
                            onPressed: null,
                            icon: LiquidGlassLayer(
                              child: LiquidStretch(
                                child: LiquidGlass(
                                  shape: LiquidRoundedSuperellipse(
                                    borderRadius: 25,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      CupertinoIcons.search,
                                      size: 25,
                                      color: Pallete.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              HapticFeedback.lightImpact();
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => const UploadSongPage(),
                                ),
                              );
                            },
                            icon: const LiquidGlassLayer(
                              child: LiquidStretch(
                                child: LiquidGlass(
                                  shape: LiquidRoundedSuperellipse(
                                    borderRadius: 25,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      CupertinoIcons.add,
                                      size: 25,
                                      color: Pallete.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                            color: Pallete.cardColor,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              size: 32,
                              CupertinoIcons.heart_fill,
                              color: Pallete.gradient1,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Liked Songs',
                            style: TextStyle(
                              fontFamily: 'Zain',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final song = data[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: ListTile(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              ref
                                  .read(currentSongNotifierProvider.notifier)
                                  .updateSong(song);
                            },
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Pallete.transparentColor,
                              backgroundImage: NetworkImage(song.thumbnail_url),
                            ),
                            title: Text(
                              song.song_name,
                              style: const TextStyle(
                                fontFamily: 'Zain',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              song.artist,
                              style: const TextStyle(
                                fontFamily: 'Zain',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return Center(child: Text(error.toString()));
          },
          loading: () => const Loader(
            color: Pallete.gradient1,
            backgroundColor: Pallete.transparentColor,
          ),
        );
  }
}
