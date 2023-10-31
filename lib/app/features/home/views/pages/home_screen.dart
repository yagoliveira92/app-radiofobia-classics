import 'package:app_radiofobia_classics/app/features/home/views/pages/contact_screen.dart';
import 'package:app_radiofobia_classics/app/features/home/views/pages/initial_screen.dart';
import 'package:app_radiofobia_classics/app/features/home/views/pages/player_screen.dart';
import 'package:app_radiofobia_classics/app/features/home/views/widgets/navigation_bar_widget.dart';
import 'package:app_radiofobia_classics/app/features/home/views/widgets/player_bottomsheet_widget.dart';
import 'package:app_radiofobia_classics/app/features/player_audio/controller/player_audio_controller.dart';
import 'package:app_radiofobia_classics/app/features/podcasts/view/podcasts_radiofobia_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _player = GetIt.I<PlayerAudioModel>();

  static const List<Widget> _widgetOptions = <Widget>[
    InitialScreen(),
    PodcastsRadiofobiaScreen(),
    ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomSheet: PlayerBottomsheetWidget(
        function: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PlayerScreen()),
        ),
      ),
      bottomNavigationBar: NavigationBarWidget(
        selectedIndex: _selectedIndex,
        onClick: (int index) async {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
