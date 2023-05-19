import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'dart:convert' as convert;

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({Key? key}) : super(key: key);

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  List<dynamic> episodes = [];


  void fetchEpisodes() async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(globals.episodesUrl));
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        episodes = jsonResponse['results'];
      });
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEpisodes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Episodes"),
      ),
      body: ListView.builder(
        itemCount: episodes.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.all(16),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //  image & name
                 Row(
                   children:const [
                       Padding(
                         padding:   EdgeInsets.all(8),
                         child:CircleAvatar(
                           radius: 40, // Image radius
                           backgroundImage:   NetworkImage('https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.e5PCtfLG8uFC93WAwKVUIwHaFo%26pid%3DApi&f=1&ipt=ae70bd4a658c018839cf6e0a849e5a2988be0bb66a479d7044f8c3ac11fe29a6&ipo=images'),
                         ))
                   ],
                 ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Name: ${episodes[index]['name']}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Air Date: ${episodes[index]['air_date']}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Episode: ${episodes[index]['episode']}"),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Characters: ${episodes[index]['characters'].length}",          textAlign: TextAlign.left,),
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
