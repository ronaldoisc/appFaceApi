

class ModeloPersona{
  ModeloPersona({
   this.url="",
   this.edad=0
  });
  String url;
  double edad;


  factory ModeloPersona.fromJson(Map<String, dynamic> json)=>ModeloPersona(
    url: json["url"],
    edad: json["edad"],
  );
   Map<String, dynamic> toJson() => {
        "url": url,
        "edad": edad
        
    };
}