import 'dart:convert';
import 'package:epicture/home.dart';
import 'package:epicture/login.dart';
import 'package:epicture/settings.dart';
import 'package:flutter/material.dart';
import 'package:epicture/image.dart';
import 'package:epicture/favoris.dart';
import 'package:epicture/compte.dart';
import 'package:http/http.dart' as http;
import 'package:english_words/english_words.dart';

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
  bool test = false;

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
              title: new Text("Login"),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
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

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        // NEW from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // NEW lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }
}
