import 'package:faceapi/paginas/analizarFoto.dart';
import 'package:faceapi/paginas/home.dart';
import 'package:faceapi/paginas/personasAceptadas.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(147, 54, 220, 1.0)),
      initialRoute: 'home',
      debugShowCheckedModeBanner: false,
      routes: {
        'home': (BuildContext context) => PaginaInicio(),
        'analizar': (BuildContext context) => PaginaAnalizarFoto(),
        'aceptadas': (BuildContext context) => PaginaPersonasAceptadas()
      },
    );
  }
}
