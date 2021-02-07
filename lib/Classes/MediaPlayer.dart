import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class MediaPlayer {
  static int isloop = 0;
  AudioPlayer audioPlayer; // = AudioPlayer();
  int loopcount = 24*60*60;
  int curcount = 0;
  int isrunning=0;
// int ps;
  MediaPlayer(callback) {
    // AudioPlayer.logEnabled = true;
    audioPlayer = AudioPlayer();

    // _positionSubscription =
    // if (callback != null) audioPlayer.onAudioPositionChanged.listen(callback);

    // audioPlayer.onAudioPositionChanged.listen((p) async {
    // if (!pickItem.containsKey('end')) {
    //   return;
    // });
    //   player.onDurationChanged.listen((Duration d) {
    //   print('Max duration: $d');
    //   setState(() => duration = d);
    // });
    // audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) => {
    //       print('Current player state: $s')
    //       // setState(() => playerState = s);
    //     });

    //    player.onPlayerCompletion.listen((event) {
    //   onComplete();
    //   setState(() {
    //     position = duration;
    //   });
    // });
    if (callback != null) audioPlayer.onPlayerCompletion.listen(callback);

    audioPlayer.onPlayerError.listen((msg) {
      print('*** MediaPlayer.onPlayerError error : $msg');
      isloop = 0;
      // setState(() {
      //   playerState = PlayerState.stopped;
      //   duration = Duration(seconds: 0);
      //   position = Duration(seconds: 0);
      // });
    });
  }

  getState() {
    print('@@@ MediaPlayer.getState() state ：${audioPlayer?.state}');
    return audioPlayer?.state;
  }

  play(file,[int lc=24*60*60]) async {
    isloop = 0;loopcount=lc;
    if (audioPlayer == null) audioPlayer = AudioPlayer();
    int result = await audioPlayer.play(file);
    if (result == 1) {
      isrunning=1;
      // success
      print('@@@ MediaPlayer.play($file) => success');
    } else {
      isrunning=0;
      print('*** MediaPlayer.play($file) => failed result : $result');
    }
  }

  loop(file) async {
    // getState();
    // play(file);
    isrunning=1;
    isloop = 1;
    curcount = 0;
    if (audioPlayer == null) audioPlayer = AudioPlayer();
    await audioPlayer.play(file);
    //  print('@@@ MediaPlayer.loop($file)');
    // return;
    print(
        '@@@ MediaPlayer.loop($file) => isloop : $isloop , curcount : $curcount , loopcount : $loopcount');
    Timer.periodic(Duration(seconds: 1), (t) async {
      // getState();
      if (isloop == 0 || curcount >= loopcount) {        
        t.cancel();
        t = null;
        curcount = 0;
        print(
            '@@@ MediaPlayer.loop() quit => isloop : $isloop , curcount : $curcount');

        audioPlayer.stop();
        isrunning=0;
        return;
      }

      if (audioPlayer.state.toString().endsWith('COMPLETED')) {
        // == 'AudioPlayerState.COMPLETED'
        print(
            '@@@ MediaPlayer.loop($file) => isloop : $isloop , curcount : $curcount');
        curcount++;
        await audioPlayer.play(file);
      }
    });
  }

  playLocal(file) async {
    if (audioPlayer == null) audioPlayer = AudioPlayer();

    int result = await audioPlayer.play(file, isLocal: true);
    if (result == 1) {
      // success
      print('@@@ MediaPlayer.play($file) => success');
    } else {
      print('*** MediaPlayer.play($file) => failed result : $result');
    }
  }

  pause() async {
    if (audioPlayer == null) return;

    int result = await audioPlayer.pause();
    if (result == 1) {
      // success
      // print('pause success');
      print('@@@ MediaPlayer.pause() => success  result : $result');
    } else {
      // print('pause failed');
      print('*** MediaPlayer.pause() => failed result : $result');
    }
  }

  seek(ms) async {
    if (audioPlayer == null) return;
    int result = await audioPlayer.seek(new Duration(milliseconds: ms));
    if (result == 1) {
      // print('go to success');
      print('@@@ MediaPlayer.seek($ms) => success  result : $result');
      // await audioPlayer.resume();
    } else {
      // print('go to failed');
      print('*** MediaPlayer.seek($ms) => failed result : $result');
    }
  }

  resume() async {
    if (audioPlayer == null) return;
    int result = await audioPlayer.resume();
    if (result == 1) {
      // print('go to success');
      print('@@@ MediaPlayer.resume() => success  result : $result');
      // await audioPlayer.resume();
    } else {
      // print('go to failed');
      print('*** MediaPlayer.resume() => failed result : $result');
    }
  }

  stop() async {
    if (audioPlayer == null) 
    {
      isloop = 0;isrunning=0;
      return;
    }
    int result = await audioPlayer.stop();
    isloop = 0;isrunning=0;
    if (result == 1) {
      // print('go to success');
      print('@@@ MediaPlayer.stop() => success  result : $result');
      // await audioPlayer.resume();
    } else {
      // print('go to failed');
      print('*** MediaPlayer.stop() => failed result : $result');
    }
  }

  release() async {
    if (audioPlayer == null) return;
    await audioPlayer.stop();
    int result = await audioPlayer.release();
    if (result == 1) {
      print('@@@ MediaPlayer.release() => success  result : $result');
    } else {
      print('*** MediaPlayer.release() => failed result : $result');
    }
  }
}

class CachePlayer {
  AudioCache player;
  AudioPlayer aplayer;
  CachePlayer() {
    player = AudioCache();
  }
  play(file) async {
    // await player.load(file);
    aplayer = await player.play(file);
    // player.clear(fileName)prefix: 'audios/'
  }

  loop(file) async {
    // AudioCache player = AudioCache();
    // await player.load(file);
    aplayer = await player.loop(file);
    // player.clear(fileName)
  }

  stop() async {
    // AudioCache player = AudioCache();
    // await player.load(file);
    // await player.fixedPlayer.stop();
    await aplayer?.stop();
    // player.clear(fileName)
  }
}

//   @override
// void deactivate() async{
//   print('结束');
//   int result = await audioPlayer.release();
//   if (result == 1) {
//     print('release success');
//   } else {
//     print('release failed');
//   }
//   super.deactivate();
// }
