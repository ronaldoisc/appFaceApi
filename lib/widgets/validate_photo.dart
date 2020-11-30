import 'package:faceapi/widgets/alert.dart';
import 'package:flutter/material.dart';

class Validate {
  final alert = new Alert();

  validatePhoto(BuildContext context, double edad) {
    if (edad >= 0 && edad <= 18) {
      alert.showDialogMessage(context, Icons.error_outline, Colors.red,
          "Upps! Eres menor de edad :( ", edad, "¡no tienes acceso!");

      alert.speak("Por cuestiones de seguridad no puedes ingresar");
    } else if (edad >= 18) {
      alert.showDialogMessage(context, Icons.info_outline, Colors.green,
          "Perfecto! eres mayor de edad :)  ", edad, "¡tienes acceso!");
      alert.speak("Si tienes acceso, adelante");
    }
  }
}
