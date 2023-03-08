import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';

class BackgroundMusicService {
  final assetsAudioPlayer = AssetsAudioPlayer();
  void startBgMusic() {
    
    assetsAudioPlayer.open(
      Audio.network(
          "https://vital-minds.s3.ap-south-1.amazonaws.com/vital_minds_bg_music.mp3"),
      autoStart: true,
      loopMode: LoopMode.single,
      showNotification: false,
    );
    log('music started');
  }

  void stopBgMusic() {
    assetsAudioPlayer.stop();
    log('music stopped');
  }

  void pauseBgMusic() {
    assetsAudioPlayer.pause();
    log('music paused');
  }

  void playBgMusic() {
    assetsAudioPlayer.play();
    log('play music function called');
  }

  void disposeBgMusic() {
    assetsAudioPlayer.dispose();
    log('music disposed');
  }
}
