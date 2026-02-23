import 'package:hive/hive.dart';
import 'package:music_player/features/Home/model/song_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_local_repository.g.dart';

@riverpod
HomeLocalRepository homeLocalRepository(HomeLocalRepositoryRef ref) {
  return HomeLocalRepository();
}

class HomeLocalRepository {
  final Box box = Hive.box('songsBox');

  void uploadLocalSong(SongModel song) {
    dynamic existingKey;
    for (final key in box.keys) {
      final currentSong = SongModel.fromJson(box.get(key));
      if (currentSong.id == song.id) {
        existingKey = key;
        break;
      }
    }

    if (existingKey != null) {
      box.delete(existingKey);
    }

    box.add(song.toJson());
  }

  List<SongModel> getLocalSong() {
    List<SongModel> songs = [];
    for (final key in box.keys) {
      songs.add(SongModel.fromJson(box.get(key)));
    }
    return songs;
  }
}
