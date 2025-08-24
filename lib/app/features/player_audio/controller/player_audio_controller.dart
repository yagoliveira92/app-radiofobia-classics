import 'package:app_radiofobia_classics/app/features/player_audio/model/cover_model.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class PlayerAudioModel extends BaseAudioHandler {
  final _player = AudioPlayer(
    audioLoadConfiguration: const AudioLoadConfiguration(
      darwinLoadControl: DarwinLoadControl(
        preferredForwardBufferDuration: Duration(seconds: 45),
      ),
      androidLoadControl: AndroidLoadControl(
        minBufferDuration: Duration(seconds: 20),
        maxBufferDuration: Duration(seconds: 60),
        bufferForPlaybackDuration: Duration(seconds: 2),
        bufferForPlaybackAfterRebufferDuration: Duration(seconds: 5),
        prioritizeTimeOverSizeThresholds: true,
      ),
    ),
  );
  final _url = 'https://stream.zeno.fm/zgi6bmrynh1uv';

  final _coverModel = CoverModel();

  PlayerAudioModel() {
    // Broadcast that we're loading, and what controls are available.
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.play],
      processingState: AudioProcessingState.loading,
    ));
    // Connect to the URL
    _player.setUrl(_url).then(
      (_) {
        // Broadcast that we've finished loading
        playbackState.add(playbackState.value.copyWith(
          processingState: AudioProcessingState.ready,
          playing: true,
          controls: [MediaControl.stop],
        ));

        mediaItem.add(
          MediaItem(
            id: 'audio_1',
            title: 'Rádiofobia Classics!',
            album: 'Rádiofobia Podcast Network',
            artUri: Uri.parse(
                'https://radiofobia.com.br/podcast/wp-content/uploads/2023/09/cover_classics_3000x3000-v2-768x768.jpg'),
          ),
        );
      },
    );
  }

  // The most common callbacks:
  @override
  Future<void> play() async {
    playbackState.add(playbackState.value.copyWith(
      playing: true,
      controls: [MediaControl.stop],
    ));
    await _player.play();
  }

  //Usado na notificação apenas.
  @override
  Future<void> pause() async {
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      controls: [MediaControl.play],
    ));
    await _player.stop();
  }

  @override
  Future<void> stop() async {
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      controls: [MediaControl.play],
    ));
    await _player.stop();
  }

  Future<MediaItem> getMetadata() async {
    final responseApi = await _coverModel.getStreamingMetadata(url: _url);
    if (responseApi.isNotEmpty) {
      RegExp exp = RegExp('(?<=<body>)(.*)(?=</body>)');
      RegExpMatch? matches = exp.firstMatch(responseApi);
      List<String> responseShoutcast = matches?.group(0)?.split(',') ?? [''];
      mediaItem.add(MediaItem(
        id: 'audio_1',
        title: responseShoutcast[6],
        artist: 'Rádiofobia Podcast Network',
        album: 'Rádiofobia Classics',
        artUri: Uri.parse(
            'https://radiofobia.com.br/podcast/wp-content/uploads/2023/09/cover_classics_3000x3000-v2-768x768.jpg'),
      ));
      return MediaItem(
        id: 'audio_1',
        title: responseShoutcast[6],
        artist: 'Rádiofobia Podcast Network',
        album: 'Rádiofobia Classics',
        artUri: Uri.parse(
            'https://radiofobia.com.br/podcast/wp-content/uploads/2023/09/cover_classics_3000x3000-v2-768x768.jpg'),
      );
    }
    mediaItem.add(
      MediaItem(
        id: 'audio_1',
        title: 'Rádiofobia Classics!',
        album: 'Rádiofobia Podcast Network',
        artUri: Uri.parse(
            'https://radiofobia.com.br/podcast/wp-content/uploads/2023/09/cover_classics_3000x3000-v2-768x768.jpg'),
      ),
    );
    return MediaItem(
      id: 'audio_1',
      title: 'Rádiofobia Classics!',
      album: 'Rádiofobia Podcast Network',
      artUri: Uri.parse(
          'https://radiofobia.com.br/podcast/wp-content/uploads/2023/09/cover_classics_3000x3000-v2-768x768.jpg'),
    );
  }
}
