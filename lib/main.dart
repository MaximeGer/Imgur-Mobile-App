import 'package:epicture/home.dart';
import 'package:epicture/login.dart';
import 'package:epicture/settings.dart';
import 'package:flutter/material.dart';

import 'package:epicture/favoris.dart';
import 'package:epicture/compte.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epicture',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF141518)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text('Imgur'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.more_vert),
              )),
          IconButton(
            icon: const Icon(Icons.login),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: HomePage(),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text("Navigation"),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: new Text("Compte"),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => ComptePage()),
                );
              },
            ),
            ListTile(
              title: new Text("Favorie"),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => FavorisPage()),
                );
              },
            ),
            ListTile(
              title: new Text("Settings"),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
