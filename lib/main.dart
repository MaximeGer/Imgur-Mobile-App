import 'package:epicture/home.dart';
import 'package:epicture/login.dart';
import 'package:epicture/settings.dart';
import 'package:epicture/upload.dart';
import 'package:flutter/material.dart';

import 'package:epicture/favoris.dart';
import 'package:epicture/compte.dart';
import 'package:epicture/imports.dart';

void main() {
  runApp(MyApp());
}

String search = "";
String filter = "viral";

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
    _filterListener.addListener(() {
      search = _filterListener.text;
      setState(() {});
    });
    super.initState();
  }

  Widget myPopMenu() {
    return PopupMenuButton(
        icon: Icon(Icons.filter_alt),
        onSelected: (value) {
          setState(() {
            switch (value) {
              case 1:
                filter = "viral";
                break;
              case 2:
                filter = "top";
                break;
              case 3:
                filter = "time";
                break;
              default:
            }
          });
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      //   child: Icon(Icons.print),
                      // ),
                      Text('Viral')
                    ],
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      //   child: Icon(Icons.share),
                      // ),
                      Text('Top')
                    ],
                  )),
              PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      //   child: Icon(Icons.add_circle),
                      // ),
                      Text('Time')
                    ],
                  ))
            ]);
  }

  final TextEditingController _filterListener = new TextEditingController();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = Text('Imgur');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1bb76e),
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
                        controller: _filterListener,
                        decoration:
                            new InputDecoration(hintText: 'Search by $filter'),
                      );
                    } else {
                      this._searchIcon = new Icon(Icons.search);
                      this._appBarTitle = new Text('Imgur');
                      _filterListener.clear();
                    }
                  });
                },
                child: _searchIcon,
              )),
          myPopMenu(),
          IconButton(
            icon: const Icon(Icons.login),
            color: Colors.white,
            onPressed: () {
              if (token.isEmpty) {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => LoginPage()),
                );
              } else {
                token = "";
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Disconnected"),
                ));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: HomePage(),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFF474a51),
        ),
        child: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                height: 65,
                child: DrawerHeader(
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Navigation",
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(color: Color(0xFF1bb76e)),
                ),
              ),
              ListTile(
                title: new Text(
                  "Compte",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => ComptePage()),
                  );
                },
              ),
              ListTile(
                title: new Text(
                  "Favoris",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => FavorisPage()),
                  );
                },
              ),
              ListTile(
                title: new Text(
                  "Settings",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
              ListTile(
                title: new Text(
                  "Upload",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => UploadPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
