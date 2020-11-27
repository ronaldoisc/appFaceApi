import 'package:faceapi/paginas/analizarFoto.dart';
import 'package:faceapi/paginas/personasAceptadas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaInicio extends StatefulWidget {
  @override
  _PaginaInicioState createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {
  int _selectedIndex = 0;
  final _pages = [PaginaAnalizarFoto(), PaginaPersonasAceptadas()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: _selectedIndex,
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Inicio'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.thumb_up),
              title: new Text('Aceptados'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.drag_handle), title: Text('Nosotros'))
          ],
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body:
            //Text("Hola")
            _pages[_selectedIndex]);
  }
}
