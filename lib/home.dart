import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:english_words/english_words.dart';

var client_id = "761207468cb80bd";
var token = "";

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void homeData() async {
    var response = await http.get(
      Uri.parse('https://api.imgur.com/3/image/T0IBWsL'),
      headers: {'Authorization': 'Client-ID ' + client_id},
    );

    final repStr = jsonDecode(response.body);

    print(repStr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RandomWords()
        // Container(
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //       //color: Color(0xFF141518),
        //       ),
        //   child: Column(
        //     children: <Widget>[
        //       SizedBox(
        //         height: 150,
        //       ),
        //       Text(
        //         "Home Page",
        //         style: TextStyle(color: Colors.white, fontSize: 40),
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //       ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //           primary: Color(0xFF1bb76e), // background
        //           onPrimary: Colors.white, // foreground
        //           textStyle: TextStyle(fontSize: 18),
        //           minimumSize: Size(150, 45),
        //         ),
        //         onPressed: homeData,
        //         child: Text(
        //           'homeData',
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}
