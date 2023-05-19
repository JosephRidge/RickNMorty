import 'package:flutter/material.dart';
import 'package:testapp/characters_page.dart';
import 'package:testapp/episodes_page.dart';
import 'package:testapp/locations_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick n Morty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  int currentPage =0;
  List pages = const [CharactersPage(), EpisodesPage(), LocationsPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body:pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
         items: const [
           BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: "Characters"),
           BottomNavigationBarItem(icon: Icon(Icons.pin_drop),label: "Locations"),
           BottomNavigationBarItem(icon: Icon(Icons.video_library),label: "Episodes"),
        ],
        currentIndex: currentPage,
        onTap: (index){
           setState(() {
             currentPage = index;
           });
        },
      ),
    );
  }
}
