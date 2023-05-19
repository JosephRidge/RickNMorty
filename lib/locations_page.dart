import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'dart:convert' as convert;

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  List<dynamic> locations = [];


  void fetchLocations() async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(globals.locationsUrl));
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        locations = jsonResponse['results'];
      });
      print("==>${jsonResponse['results']}");
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLocations();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Locations"),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.all(16),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Name: ${locations[index]['name']}",          textAlign: TextAlign.left,),
                      Text("Type: ${locations[index]['type']}",  textAlign: TextAlign.start,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Dimension: ${locations[index]['dimension']}",          textAlign: TextAlign.left,),
                     ],
                  ),
                  //  residents
                  // Row(children: [
                  //   if(locations[index]['residents'][0] != null)
                  //
                  //          Padding(
                  //             padding: const EdgeInsets.all(8),
                  //             child: CircleAvatar(
                  //               radius: 20, // Image radius
                  //               backgroundImage: NetworkImage(
                  //                   locations[index]['residents'][0]),
                  //             ))
                  //       ,
                  //   if(locations[index]['residents'][1] != null)Padding(
                  //       padding: const EdgeInsets.all(8),
                  //       child:CircleAvatar(
                  //         radius: 20, // Image radius
                  //         backgroundImage: NetworkImage(locations[index]['residents'][1]),
                  //       )),
                  // ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Name: ${locations[index]['name']}"),
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
