import 'dart:io';

import 'package:faceapi/modelo/modeloPersona.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class PersonaProvaider {
/*subir imagen a cloudinary y obtener url de la imagen*/
  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dxuaejvq2/image/upload?upload_preset=xfwphq3z');
    final mimeType = mime(imagen.path).split("/");
    final imagenUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    imagenUploadRequest.files.add(file);

    final streamResponse = await imagenUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print("Algo salio mal: ${resp.body}");
      return null;
    }
    final respData = json.decode(resp.body);
    return respData["secure_url"];
  }

  Future<int> enviarDatos(ModeloPersona persona) async {
    final endPoint = "https://age-detector.herokuapp.com/";
    final response = await http.post(endPoint, body: {"url": persona.url});
    final decode = json.decode(response.body);

    int age = decode["age"];
    if (response.statusCode == 200) {
      return age;
    } else {
      return -1;
    }
  }

  Future<List<ModeloPersona>> obtenerPersonas() async {
    final endPoint = "https://age-detector.herokuapp.com/accepted";
    final response = await http.get(endPoint);
    if (response.statusCode == 200) {
      return modeloPersonaFromJson(response.body);
    }
    return null;
  }
}
