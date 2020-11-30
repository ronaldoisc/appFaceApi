import 'dart:convert';

List<Person> personFromJson(String str) =>
    List<Person>.from(json.decode(str).map((x) => Person.fromJson(x)));

String personToJson(List<Person> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Person {
  Person({
    this.id,
    this.url,
    this.age,
    this.gender,
  });

  int id;
  String url = " ";
  int age;
  String gender;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
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
