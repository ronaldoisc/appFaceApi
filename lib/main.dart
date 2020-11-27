import 'package:faceapi/pages/analizarFoto.dart';
import 'package:faceapi/pages/home.dart';
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
        'home': (BuildContext context) => HomePage(),
        'analizar': (BuildContext context) => PaginaAnalizarFoto(),
        // 'aceptadas': (BuildContext context) => PaginaPersonasAceptadas()
      },
    );
  }
}
