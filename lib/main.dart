import 'dart:async';
<<<<<<< Updated upstream
import 'package:camera/camera.dart';
import 'package:faceapi/pages/analyze.dart';
=======
import 'package:faceapi/pages/home_page.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: HomePage()
    ),
  );
}
