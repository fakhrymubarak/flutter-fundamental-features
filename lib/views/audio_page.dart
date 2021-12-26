import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioPage extends StatefulWidget {
  final String url;
  final bool isAsset;

  const AudioPage({
    Key? key,
    required this.url,
    this.isAsset = false,
  }) : super(key: key);

  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> with TickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  late AudioCache _audioCache;
  PlayerState _playerState = PlayerState.STOPPED;

  bool get _isPlaying => _playerState == PlayerState.PLAYING;

  bool get _isLocal => !widget.url.contains('https');

  late AnimationController _animationIconController;
  Duration _duration = const Duration();
  Duration _position = const Duration();

  @override
  void initState() {
    _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    _audioCache = AudioCache(fixedPlayer: _audioPlayer);
    _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.STOPPED;
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });

    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });

    _animationIconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
      reverseDuration: const Duration(milliseconds: 750),
    );

    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  _playPause() async {
    if (_playerState == PlayerState.PLAYING) {
      final playerResult = await _audioPlayer.pause();
      if (playerResult == 1) {
        setState(() {
          _playerState = PlayerState.PAUSED;
        });
      }
    } else if (_playerState == PlayerState.PAUSED) {
      final playerResult = await _audioPlayer.resume();
      if (playerResult == 1) {
        setState(() {
          _playerState = PlayerState.PLAYING;
        });
      }
    } else {
      if (widget.isAsset) {
        _audioPlayer = await _audioCache.play(widget.url);
        setState(() {
          _playerState = PlayerState.PLAYING;
        });
      } else {
        final playerResult =
            await _audioPlayer.play(widget.url, isLocal: _isLocal);
        if (playerResult == 1) {
          setState(() {
            _playerState = PlayerState.PLAYING;
          });
        }
      }
    }
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    _audioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Slider(
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
                value: _position.inSeconds.toDouble(),
                max: _duration.inSeconds.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    seekToSecond(value.toInt());
                    value = value;
                  });
                },
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  _playPause();
                  _isPlaying
                      ? _animationIconController.reverse()
                      : _animationIconController.forward();
                },
                child: ClipOval(
                  child: Container(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        size: 40,
                        progress: _animationIconController,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
