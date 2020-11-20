import 'package:faceapi/widgets/alertas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Validar{
final alerta=new Alertas();
validarFoto(BuildContext context,double edad) {
    if (edad >= 0 && edad <= 18) {
      alerta.showDialogMessage(context, Icons.error_outline, Colors.red,
          "Upps! Eres menor de edad :( ", edad, "¡no tienes acceso!");

          alerta.speak("Por cuestiones de seguridad no puedes ingresar");
    } else if (edad > 18 && edad < 60) {
      alerta.showDialogMessage(context, Icons.info_outline, Colors.green,
          "Perfecto! eres mayor de edad :)  ", edad, "¡tienes acceso!");
          alerta.speak("Si tienes acceso, adelante");
    } 
  }
}