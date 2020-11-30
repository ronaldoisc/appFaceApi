import 'dart:io';
import 'package:faceapi/model/person.dart';
import 'package:faceapi/pages/accepted_people.dart';
import 'package:faceapi/repositories/person_repository.dart';
import 'package:faceapi/widgets/alert.dart';
import 'package:faceapi/widgets/validate_photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

///articles/articles_repository.dart
class AnalyzeImage extends StatefulWidget {
  final String imagePath;

  @override
  _AnalyzeImageState createState() => _AnalyzeImageState();

  const AnalyzeImage({Key key, this.imagePath = ""}) : super(key: key);
}

class _AnalyzeImageState extends State<AnalyzeImage> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.imagePath != "") {
<<<<<<< HEAD
      foto = File(this.widget.imagePath);
      setState(() {});
=======
      foto = File(widget.imagePath);
      setState(() {
        foto = File(widget.imagePath);
      });
>>>>>>> 2950fc0202b2c2d3058413a9ef8eebd43d321d48
    }
  }

  Person person = new Person();
  final personaProvaider = new PersonRepository();
  final validarFoto = new Validate();
  final alertas = new Alert();
  final formkey = GlobalKey<FormState>();
  File foto;
  var _cargando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppFaceApi"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _pickPhoto,
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AcceptedPeoplePage(),
                )),
          ),
        ],
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            _titulo(),
            _mostrarFoto(),
            _espacio(),
            _loanding(),
            _botonEnviar(),
          ],
        ),
      ),
    );
  }

  _espacio() {
    return SizedBox(
      height: 10,
    );
  }

  _loanding() {
    if (_cargando == true) {
      return Positioned.fill(
          child: Container(
            child: Center(
              child: CupertinoActivityIndicator(
                radius: 15,
              ),
            ),
      ));
    } else {
      return Container();
    }
  }

  _titulo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "¡Detectando menores de edad!",
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.justify,
      ),
    );
  }

  _botonEnviar() {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 17.0),
          child: Text(
            _cargando == false ? "Analizar foto" : "Espere por favor",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 0.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: !_cargando ? () => _sumit() : null);
  }

  _sumit() async {
    print(foto);
    if (foto == null) {
      alertas.showAlertDialog(context);
      return;
    }

    if (_cargando) return;

    final isValid = formkey.currentState.validate();
    if (isValid) {
      setState(() {
        formkey.currentState.save();
        _cargando = true;
      });
    }

    if (foto != null) {
      person.url = await personaProvaider.uploadImage(foto);
    }
    if (person.url != null) {
<<<<<<< HEAD
      final respuesta = await personaProvaider.enviarDatos(person);
     
      setState(() {
        _cargando = false;
      });
      
      double edad=respuesta[0]["faceAttributes"]["age"];
      String genero=respuesta[0]["faceAttributes"]["gender"];
      person.age=edad;
      person.gender=genero;
       validarFoto.validarFoto(context, edad);
     // personaProvaider.almacenarDatosPersona(person);
=======
      final edad = await personaProvaider.sendData(person);
      print(edad);
      setState(() {
        _cargando = false;
      });
      validarFoto.validatePhoto(context, edad);
>>>>>>> 2950fc0202b2c2d3058413a9ef8eebd43d321d48
    }
  }

  Widget _mostrarFoto() {
    if (person.url != null) {
      return FadeInImage(
        image: NetworkImage(person.url),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 500.0,
        fit: BoxFit.cover,
      );
    } else {
      if (foto != null) {
        return Image.file(foto,
            fit: BoxFit.cover, height: 500.0, width: double.infinity);
      }
      return Container(child: Image.asset("assets/no-image.png"));
    }
  }

  _pickPhoto() async {
    var picketPhoto = await _picker.getImage(source: ImageSource.gallery);
    if (picketPhoto.path == "") return;
    foto = File(picketPhoto.path);
    setState(() {});
  }
}
