import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/core/theme/app_pallet.dart';

class AudioWave extends StatefulWidget {
  final String path;
  final Color liveColor;
  const AudioWave({super.key, required this.path, required this.liveColor});

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  void initAudioPlayer() async {
    await playerController.preparePlayer(path: widget.path);
  }

  Future<void> playAndPause() async {
    if (!playerController.playerState.isPlaying) {
      await playerController.startPlayer();
    } else if (!playerController.playerState.isPaused) {
      await playerController.pausePlayer();
    }
    setState(() {});
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: playAndPause,
          icon: playerController.playerState.isPlaying
              ? const Icon(CupertinoIcons.pause_solid)
              : const Icon(CupertinoIcons.play_arrow_solid),
        ),
        Expanded(
          child: AudioFileWaveforms(
            size: const Size(double.infinity, 100),
            playerController: playerController,
            playerWaveStyle: PlayerWaveStyle(
              spacing: 5,
              showSeekLine: false,
              fixedWaveColor: Pallete.inactiveBottomBarItemColor,
              liveWaveColor: widget.liveColor,
            ),
          ),
        ),
      ],
    );
  }
}
