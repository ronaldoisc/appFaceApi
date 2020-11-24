import 'dart:io';

import 'package:faceapi/modelo/modeloPersona.dart';
import 'package:faceapi/provaider/personaProvaider.dart';
import 'package:faceapi/widgets/alertas.dart';
import 'package:faceapi/widgets/validarFoto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PaginaAnalizarFoto extends StatefulWidget {
  @override
  _PaginaAnalizarFotoState createState() => _PaginaAnalizarFotoState();
}

class _PaginaAnalizarFotoState extends State<PaginaAnalizarFoto> {
  ModeloPersona modeloPersona = new ModeloPersona();
  final personaProvaider = new PersonaProvaider();
  final validarFoto = new Validar();
  final alertas=new Alertas();
  final formkey = GlobalKey<FormState>();
  File foto;
  var _cargando = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppFaceApi"),
        leading: Icon(Icons.face),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: _tomarFoto,
          ),
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
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
    if(foto==null){
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
      modeloPersona.url = await personaProvaider.subirImagen(foto);
    }
    if (modeloPersona.url != null) {
      final edad = await personaProvaider.enviarDatos(modeloPersona);
      print(edad);
      setState(() {
        _cargando = false;
      });
      validarFoto.validarFoto(context, edad);
    }
  }

  Widget _mostrarFoto() {
    if (modeloPersona.url != null) {
      return FadeInImage(
        image: NetworkImage(modeloPersona.url),
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
      //return Image.asset('assets/no-image.png');
    }
  }

  _tomarFoto() async {
    setState(() {
      procesarFoto(ImageSource.camera);
    });
  }

  _seleccionarFoto() async {
    procesarFoto(ImageSource.gallery);
  }

  procesarFoto(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen, imageQuality: 50);

    if (foto != null) {
      modeloPersona.url = null;
    }

    setState(() {});
  }

  
}
