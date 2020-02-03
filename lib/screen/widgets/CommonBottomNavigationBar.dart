import 'package:flutter/material.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  CommonBottomNavigationBar({this.context, this.selectedIndex});

  final BuildContext context;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          title: Text('Book'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie),
          title: Text('Movie'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note),
          title: Text('Musician'),
        ),
      ],
      onTap: _onItemTapped,
      currentIndex: selectedIndex,
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed('/book');
        break;
      case 1:
        Navigator.of(context).pushNamed('/movie');
        break;
      case 2:
        Navigator.of(context).pushNamed('/musician');
        break;
      default:
        break;
    }
  }
}