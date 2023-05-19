import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'globals.dart' as globals;

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
List<dynamic> characters = [];

void fetchCharacters() async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(globals.charactersUrl));
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        characters = jsonResponse['results'];
      });
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCharacters();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Characters"),
      ),
      body: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.all(16),
              child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            //  image & name
              Row(children: [
                Padding(
                    padding: const EdgeInsets.all(8),
                    child:CircleAvatar(
                  radius: 50, // Image radius
                  backgroundImage: NetworkImage(characters[index]['image']),
                )),
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Name: ${characters[index]['name']}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Gender: ${characters[index]['gender']}",          textAlign: TextAlign.left,),
                  Text("Species: ${characters[index]['species']}",  textAlign: TextAlign.start,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Location: ${characters[index]['location']['name']}",  textAlign: TextAlign.start,) ,
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(child:Text("Origin: ${characters[index]['origin']['name']}",  textAlign: TextAlign.start,)) ,
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Status: ${characters[index]['status']}") ,
                ],
              ),
          const Divider(),
            ],
          ));
        },
      ),
    );
  }
}
