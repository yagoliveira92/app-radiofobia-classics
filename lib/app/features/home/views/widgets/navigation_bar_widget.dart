import 'package:flutter/material.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget(
      {super.key, required this.onClick, required this.selectedIndex});

  final Function(int) onClick;
  final int selectedIndex;

  @override
  _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: widget.onClick,
      selectedIndex: widget.selectedIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Início',
        ),
        NavigationDestination(
          icon: Icon(Icons.rss_feed_outlined),
          selectedIcon: Icon(Icons.rss_feed),
          label: 'Podcasts',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.contacts_outlined),
          icon: Icon(Icons.contacts),
          label: 'Contato',
        ),
      ],
    );
  }
}
