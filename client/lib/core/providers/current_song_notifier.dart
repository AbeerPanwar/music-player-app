import 'package:just_audio/just_audio.dart';
import 'package:music_player/features/Home/model/song_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  AudioPlayer? audioPlayer;
  bool isPlaying = false;

  @override
  SongModel? build() {
    audioPlayer = AudioPlayer();
    return null;
  }

  void updateSong(SongModel song) async {
    final audioSource = AudioSource.uri(Uri.parse(song.song_url));

    await audioPlayer!.setAudioSource(audioSource);

    audioPlayer!.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        audioPlayer!.seek(Duration.zero);
        audioPlayer!.pause();
        isPlaying = false;
        this.state = this.state?.copyWith(hex_code: this.state?.hex_code);
      }
    });

    audioPlayer!.play();
    isPlaying = true;
    state = song;
  }

  void playAndPause() {
    if (isPlaying) {
      audioPlayer?.pause();
    } else {
      audioPlayer?.play();
    }
    isPlaying = !isPlaying;
    state = state?.copyWith(hex_code: state?.hex_code);
  }
}
