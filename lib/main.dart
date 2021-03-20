import 'package:epicture/home.dart';
import 'package:epicture/login.dart';
import 'package:epicture/settings.dart';
import 'package:epicture/upload.dart';
import 'package:flutter/material.dart';

import 'package:epicture/favoris.dart';
import 'package:epicture/compte.dart';
import 'package:epicture/image.dart';

void main() {
  runApp(MyApp());
}

  String search = "";


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
  void initState() {
    _filter.addListener(() {
      search = _filter.text;
      setState(() {});
    });
    super.initState();
  }

  final TextEditingController _filter = new TextEditingController();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = Text('Imgur');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (this._searchIcon.icon == Icons.search) {
                      this._searchIcon = new Icon(Icons.close);
                      this._appBarTitle = new TextField(
                        controller: _filter,
                        decoration: new InputDecoration(hintText: 'Search...'),
                      );
                    } else {
                      this._searchIcon = new Icon(Icons.search);
                      this._appBarTitle = new Text('Imgur');
                      _filter.clear();
                    }
                  });
                },
                child: _searchIcon,
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
              title: new Text("Favoris"),
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

            ListTile(
              title: new Text("Upload"),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => UploadPage()),
                );
              },
            ),
            // Visibility(
            //     visible: token.isEmpty,
            //     child: Column(
            //       children: <Widget>[
            //         ListTile(
            //           title: new Text("Login"),
            //           onTap: () {
            //             Navigator.push(
            //               context,
            //               new MaterialPageRoute(
            //                   builder: (context) => LoginPage()),
            //             );
            //           },
            //         ),
            //       ],
            //     ),
            //     replacement: Column(
            //       children: <Widget>[
            //         ListTile(
            //           title: new Text("Compte"),
            //           onTap: () {
            //             Navigator.push(
            //               context,
            //               new MaterialPageRoute(
            //                   builder: (context) => ComptePage()),
            //             );
            //           },
            //         ),
            //         ListTile(
            //           title: new Text("Favorie"),
            //           onTap: () {
            //             Navigator.push(
            //               context,
            //               new MaterialPageRoute(
            //                   builder: (context) => FavorisPage()),
            //             );
            //           },
            //         ),
            //         ListTile(
            //           title: new Text("Settings"),
            //           onTap: () {
            //             Navigator.push(
            //               context,
            //               new MaterialPageRoute(
            //                   builder: (context) => LoginPage()),
            //             );
            //           },
            //         ),
            //       ],
            //     )),
          ],
        ),
      ),
    );
  }
}
