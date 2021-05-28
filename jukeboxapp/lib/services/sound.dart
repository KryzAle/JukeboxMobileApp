import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:rxdart/rxdart.dart';

class SoundService {
  BehaviorSubject<bool> _enableSound$;
  BehaviorSubject<bool> get enableSound$ => _enableSound$;
  AudioPlayer _fixedPlayer;
  AudioCache _player;

  SoundService() {
    _enableSound$ = BehaviorSubject<bool>.seeded(true);
    _fixedPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    _player = AudioCache(fixedPlayer: _fixedPlayer);
  }

  playSound(String sound) {
    bool isSoundEnabled = _enableSound$.value;
    if (isSoundEnabled) {
      _player.play("click.mp3");
    }
  }
  void dispose(){
    _enableSound$.close();
  }
}
