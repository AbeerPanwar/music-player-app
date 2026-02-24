import 'dart:io';
import 'dart:ui';
import 'package:fpdart/fpdart.dart';
import 'package:music_player/core/providers/current_user_notifier.dart';
import 'package:music_player/core/utils.dart';
import 'package:music_player/features/Home/model/fav_song_model.dart';
import 'package:music_player/features/Home/model/song_model.dart';
import 'package:music_player/features/Home/repository/home_local_repository.dart';
import 'package:music_player/features/Home/repository/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getAllSongs(GetAllSongsRef ref) async {
  final token = ref.watch(
    currentUserNotifierProvider.select((user) => user!.token),
  );
  final res = await ref.watch(homeRepositoryProvider).getAllSongs(token: token);

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
Future<List<SongModel>> getFavSongs(GetFavSongsRef ref) async {
  final token = ref.watch(
    currentUserNotifierProvider.select((user) => user!.token),
  );
  final res = await ref.watch(homeRepositoryProvider).getFavSongs(token: token);

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;
  late HomeLocalRepository _homeLocalRepository;

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required Color selectedColor,
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.uploadSong(
      selectedAudio: selectedAudio,
      selectedThumbnail: selectedThumbnail,
      songName: songName,
      artist: artist,
      hexCode: rgbToHex(selectedColor),
      token: ref.read(currentUserNotifierProvider)!.token,
    );

    // ignore: unused_local_variable
    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      Right(value: final r) => state = AsyncValue.data(r),
    };
  }

  List<SongModel> getRecentlyPlayedSongs() {
    return _homeLocalRepository.getLocalSong();
  }

  Future<void> favoriteSong({required String songId}) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.favoriteSong(
      songId: songId,
      token: ref.read(currentUserNotifierProvider)!.token,
    );

    // ignore: unused_local_variable
    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      Right(value: final r) => _favSongSuccess(r, songId),
    };
  }

  AsyncValue _favSongSuccess(bool isFavorited, String songId) {
    final userNotifier = ref.read(currentUserNotifierProvider.notifier);
    if (isFavorited) {
      userNotifier.addUser(
        ref
            .read(currentUserNotifierProvider)!
            .copyWith(
              favorites: [
                ...ref.read(currentUserNotifierProvider)!.favorites,
                FavSongModel(id: '', song_id: songId, user_id: ''),
              ],
            ),
      );
    } else {
      userNotifier.addUser(
        ref
            .read(currentUserNotifierProvider)!
            .copyWith(
              favorites: ref
                  .read(currentUserNotifierProvider)!
                  .favorites
                  .where((fav) => fav.song_id != songId)
                  .toList(),
            ),
      );
    }
    ref.invalidate(getFavSongsProvider);
    return state = AsyncValue.data(isFavorited);
  }
}
