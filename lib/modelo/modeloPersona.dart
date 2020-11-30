
import 'dart:convert';

List<ModeloPersona> modeloPersonaFromJson(String str) => List<ModeloPersona>.from(json.decode(str).map((x) => ModeloPersona.fromJson(x)));

String modeloPersonaToJson(List<ModeloPersona> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModeloPersona {
    ModeloPersona({
        this.id,
        this.url,
        this.age,
        this.gender,
    });

    int id;
    String url=" ";
    double age;
    String gender;

    factory ModeloPersona.fromJson(Map<String, dynamic> json) => ModeloPersona(
        id: json["id"],
        url: json["url"],
        age: json["age"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "age": age,
        "gender": gender,
    };
}
