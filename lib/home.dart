import 'package:flutter/material.dart';
import 'package:epicture/imports.dart';
import 'package:epicture/main.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<dynamic>>(
            future: fetch(
                search.trim().isNotEmpty
                    ? 'https://api.imgur.com/3/gallery/search/$filter/day/0?q=$search'
                    : 'https://api.imgur.com/3/gallery/hot/$filter/day/0?showViral=true&mature=true&album_previews=false',
                {"Authorization": 'Client-ID ' + clientId}),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                snapshot.data.removeWhere((i) => ((i["Homes"] != null &&
                        i["Homes"].length != 0 &&
                        i["Homes"][0]["type"].contains('mp4')) ||
                    (i["cover"] == null)));
                return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return card(snapshot, index, context);
                    });
              } else
                return Card(child: Text("Pas d'Homes retrouvées"));
            }),
      ),
    );
  }
}
