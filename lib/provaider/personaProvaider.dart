import 'dart:io';

import 'package:faceapi/modelo/modeloPersona.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import '../modelo/modeloPersona.dart';

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

  Future<List> enviarDatos(ModeloPersona persona)async{
    final endPoint="https://southcentralus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=age,gender&recognitionModel=recognition_01&returnRecognitionModel=false&detectionModel=detection_01";
   final response=await http.post(endPoint,
    headers: {
     'Content-Type':'application/json',
     'Ocp-Apim-Subscription-Key': '4d7929702c5d4c7daf0fdb3b7c04ea96'
   },

   body: jsonEncode({'url': persona.url}));
   List parsed=json.decode(response.body);

   if(response.statusCode==200){
     return parsed;
   }
  }
Future<bool> almacenarDatosPersona(ModeloPersona persona)async{
  final endPoint="";
  final response=await http.post(endPoint, body: {
    "url":persona.url,
    "age":persona.age,
    "gender":persona.gender
  });
  final decode=json.decode(response.body);
  print(decode);
  if(response.statusCode==200){
    return true;
  }else{
    return false;
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
