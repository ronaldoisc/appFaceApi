import 'package:flutter/material.dart';
import 'package:tts/tts.dart';

<<<<<<< HEAD:lib/widgets/alertas.dart
class Alertas {
  void showDialogMessage(BuildContext context, IconData icono, Color color,
      String title, double edad, subtitle) {
=======
class Alert {
  void showDialogMessage(BuildContext context, IconData icon, Color color,
      String title, int age, subTitle) {
>>>>>>> 2950fc0202b2c2d3058413a9ef8eebd43d321d48:lib/widgets/alert.dart
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 100, color: color),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text("Edad: " + age.toString()),
              Text(subTitle)
            ],
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 40),
              child: new FlatButton(
                child: new Text("Aceptar"),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Error"),
            content:
                Text("Debe de tomar una fotografia,¡Intentelo nuevamente!"),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  "CERRAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  speak(String text) async {
    Tts.speak(text);
  }
}
