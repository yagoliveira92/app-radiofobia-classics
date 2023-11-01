import 'dart:async';

import 'package:app_radiofobia_classics/app/features/player_audio/controller/player_audio_controller.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_scroll/text_scroll.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  final _player = GetIt.I<PlayerAudioModel>();
  late AnimationController _controller;
  late Animation<double> _animation;
  late StreamController<MediaItem> _streamController;
  late Timer _timer;
  bool buttonState = true;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<MediaItem>();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _fetchData());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..forward()
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  dispose() {
    _controller.dispose();
    _streamController.close();
    _timer.cancel();
    super.dispose();
  }

  void buttonChange() {
    if (_player.playbackState.value.playing) {
      _controller.forward();
      _player.stop();
    } else {
      _controller.reverse();
      _player.play();
    }
  }

  void _fetchData() async {
    try {
      if (!_streamController.isClosed) {
        MediaItem mediaItem = await _player.getMetadata();
        _streamController.sink.add(mediaItem);
      }
    } catch (e) {
      if (!_streamController.isClosed) {
        _streamController.sink.addError(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4B4B4B),
        title: Text('Rádiofobia Classics'),
      ),
      backgroundColor: const Color(0xFF222222),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: StreamBuilder<MediaItem>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: Card(
                        elevation: 10,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Image.network(
                                snapshot.data?.artUri.toString() ??
                                    'https://radiofobia.com.br/podcast/wp-content/uploads/2023/09/cover_classics_3000x3000-v2-768x768.jpg',
                                height: 250,
                              ),
                            ),
                            if (!snapshot.hasData)
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: TextScroll(
                        snapshot.hasData
                            ? snapshot.data?.title ?? 'Rádiofobia Classics'
                            : 'Obtendo música...',
                        mode: TextScrollMode.endless,
                        textAlign: TextAlign.center,
                        velocity:
                            const Velocity(pixelsPerSecond: Offset(50, 0)),
                        intervalSpaces: 10,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      'Rádiofobia Podcast Network',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        const link =
                            'https://play.google.com/store/apps/details?id=br.dev.yago.radiofobia.classics';
                        Share.share(
                            'Clique aqui e conheça o seu Rádiofobia Classics: $link');
                      },
                      child: const Text(
                        'Compartilhar',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    StreamBuilder<PlaybackState>(
                      stream: _player.playbackState,
                      builder: (context, snapshot) {
                        return Builder(
                          builder: (context) {
                            if (_player.playbackState.value.playing) {
                              _controller.reverse();
                            } else {
                              _controller.forward();
                            }
                            return InkWell(
                              onTap: () => buttonChange(),
                              child: Container(
                                width: 150,
                                height: 150,
                                margin: const EdgeInsets.all(7.5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 15,
                                  ),
                                ),
                                child: Center(
                                  child: AnimatedIcon(
                                    color: Colors.white,
                                    icon: AnimatedIcons.pause_play,
                                    progress: _animation,
                                    size: 100.0,
                                    semanticLabel: 'Play Audio',
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
