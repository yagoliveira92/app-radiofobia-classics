import 'dart:async';

import 'package:app_radiofobia_classics/app/features/player_audio/controller/player_audio_controller.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:text_scroll/text_scroll.dart';

class PlayerBottomsheetWidget extends StatefulWidget {
  const PlayerBottomsheetWidget({
    required this.function,
    super.key,
  });

  final VoidCallback function;

  @override
  _PlayerBottomsheetWidgetState createState() =>
      _PlayerBottomsheetWidgetState();
}

class _PlayerBottomsheetWidgetState extends State<PlayerBottomsheetWidget>
    with SingleTickerProviderStateMixin {
  final PlayerAudioModel _player = GetIt.I<PlayerAudioModel>();
  late AnimationController _controller;
  late Animation<double> _animation;
  late StreamController<MediaItem> _streamController;
  late Timer _timer;
  bool buttonState = true;

  @override
  void initState() {
    super.initState();
    _player.play();
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

  void buttonChange() {
    if (_player.playbackState.value.playing) {
      _controller.forward();
      _player.stop();
    } else {
      _controller.reverse();
      _player.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (dragStartDetails) {
        widget.function();
      },
      onTap: () {
        widget.function();
      },
      child: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: Color(
            0xFFFFE173,
          ),
        ),
        child: StreamBuilder<MediaItem>(
          initialData: MediaItem(
            id: 'audio_1',
            title: 'Rádiofobia Classics!',
            album: 'Rádiofobia Podcast Network',
            artUri: Uri.parse(
                'https://radiofobia.com.br/podcast/wp-content/uploads/2023/09/cover_classics_3000x3000-v2-768x768.jpg'),
          ),
          stream: _streamController.stream,
          builder: (context, snapshot) {
            return Row(
              children: [
                const Spacer(flex: 1),
                Image.network(
                  snapshot.data?.artUri.toString() ??
                      'https://radiofobia.com.br/podcast/wp-content/uploads/2023/09/cover_classics_3000x3000-v2-768x768.jpg',
                  height: 50,
                ),
                const Spacer(flex: 1),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextScroll(
                        snapshot.hasData
                            ? snapshot.data?.title ?? 'Rádiofobia Classics'
                            : 'Obtendo música...',
                        mode: TextScrollMode.endless,
                        intervalSpaces: 10,
                        velocity:
                            const Velocity(pixelsPerSecond: Offset(50, 0)),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text(
                      snapshot.data?.album ?? 'Rádiofobia Podcast Network',
                    )
                  ],
                ),
                const Spacer(flex: 7),
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
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.all(7.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xff3F3D40),
                                width: 6,
                              ),
                            ),
                            child: Center(
                              child: AnimatedIcon(
                                color: const Color(0xff3F3D40),
                                icon: AnimatedIcons.pause_play,
                                progress: _animation,
                                size: 30.0,
                                semanticLabel: 'Play Audio',
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const Spacer(flex: 1),
              ],
            );
          },
        ),
      ),
    );
  }
}
