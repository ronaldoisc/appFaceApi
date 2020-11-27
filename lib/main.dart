import 'dart:async';

import 'package:camera/camera.dart';
import 'package:faceapi/pages/analyze.dart';
import 'package:faceapi/widgets/DisplayPicture.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
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
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final path =
                join((await getTemporaryDirectory()).path, '${DateTime.now()}');
            await _controller.takePicture(path);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalyzeImage(imagePath: path),
                ));
          } catch (e) {
            print(e);
          }
        },
      ),
    );
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
        ));
  }

  Widget cameraWidget(context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
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
