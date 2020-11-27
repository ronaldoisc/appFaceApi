import 'package:faceapi/pages/analizarFoto.dart';
import 'package:faceapi/pages/personasAceptadas.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _pages = [PaginaAnalizarFoto(), PaginaPersonasAceptadas()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: _selectedIndex,
          // this will be set when a new tab is tapped
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up),
              label: 'Aceptados',
            ),
          ],
          onTap: (int index) {
            setState(() => _selectedIndex = index);
          },
        ),
        body: _pages[_selectedIndex]);
  }
}
