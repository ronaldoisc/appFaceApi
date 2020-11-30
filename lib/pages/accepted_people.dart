import 'package:faceapi/model/person.dart';
import 'package:faceapi/repositories/person_repository.dart';
import 'package:flutter/material.dart';

class AcceptedPeoplePage extends StatefulWidget {
  @override
  _AcceptedPeoplePageState createState() =>
      _AcceptedPeoplePageState();
}

class _AcceptedPeoplePageState extends State<AcceptedPeoplePage> {
  final personProvider = new PersonRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: personProvider.getPeople(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return _ListaPersonas(snapshot.data);
            }
          }),
    );
  }
}

class _ListaPersonas extends StatelessWidget {
  final List<Person> personas;

  _ListaPersonas(this.personas);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: personas.length,
        itemBuilder: (BuildContext context, int index) {
          final persona = personas[index];
          return Card(
            color: Colors.grey[200],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Column(
                children: [
                  Text(
                    "Edad: ${persona.age}    Genero: ${persona.gender == "male" ? "masculino" : "Femenino"}",
                    style: TextStyle(fontSize: 20),
                  ),
                  FadeInImage(
                    placeholder: AssetImage("assets/jar-loading.gif"),
                    image: NetworkImage(persona.url),
                    fit: BoxFit.cover,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 30)),
                ],
              ),
            ),
          );
        });
  }
}
