import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:faceapi/pages/analyze.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  _initializeCamera() async{
    final cameras = await availableCameras();
    _controller = CameraController(cameras.first, ResolutionPreset.low);
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          cameraWidget(context),
          // cameraIcon(),
          // leftAction(),
          rightAction(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomSheet: Padding(padding: EdgeInsets.only(bottom: 100.0)),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.camera,
          color: Colors.purple,
          size: 55.0,
        ),
        foregroundColor: Colors.purple,
        splashColor: Colors.white,
        backgroundColor: Colors.white,
        onPressed: ()  {
          _takePicture(context);
        },
      ),
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  _takePicture(context) async{
    await _initializeControllerFuture;

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/appFaceApi';
    await Directory(dirPath).create(recursive: true);

    final String filePath = '$dirPath/${timestamp()}.jpg';

    if(_controller.value.isTakingPicture) return null;

    try {
      await _controller.takePicture(filePath);
    } on CameraException catch (e) {
      print(e);
      return null;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnalyzeImage(imagePath: filePath),
        ));
  }
  Widget rightAction() {
    return Align(
        alignment: FractionalOffset.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(right: 40.0, bottom: 20.0),
          child: IconButton(
            icon: Icon(Icons.filter),
            iconSize: 30.0,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalyzeImage(),
                )),
          ),
        )
    );
  }

  Widget cameraWidget(context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_controller);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
