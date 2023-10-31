import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app/features/home/views/pages/home_screen.dart';
import 'app/features/player_audio/controller/player_audio_controller.dart';
import 'app/utils/generate_material_color.dart';

// ignore: unused_element
late AudioHandler _audioHandler;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<PlayerAudioModel>(PlayerAudioModel());
  _audioHandler = await AudioService.init(
    builder: () => GetIt.I<PlayerAudioModel>(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'br.dev.yago.radiofobia.channel.audio',
      androidNotificationChannelName: 'Radiofobia Classics',
      notificationColor: Color(0xFF4B4B4B),
      androidStopForegroundOnPause: true,
      androidNotificationOngoing: true,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radiofobia Classics',
      theme: ThemeData(
        primaryColor: GenerateMaterialColor.generate(
          const Color(0xFFFFE173),
        ),
        useMaterial3: true,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF4B4B4B),
          indicatorColor: const Color(0xFF222222),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              color: Colors.white,
            ),
          ),
          iconTheme: MaterialStateProperty.all(
            const IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF222222),
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
