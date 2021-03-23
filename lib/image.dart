import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:epicture/imports.dart';
import 'package:epicture/main.dart';

class ImagePage extends StatefulWidget {
  ImagePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<dynamic>>(
            future: fetch(
                //'https://api.imgur.com/3/gallery/hot/viral/day/0?showViral=true&mature=true&album_previews=false'
                search.trim().isNotEmpty
                    ? 'https://api.imgur.com/3/gallery/search/$filter/day/0?q=$search'
                    : 'https://api.imgur.com/3/gallery/hot/$filter/day/0?showViral=true&mature=true&album_previews=false',
                {"Authorization": 'Client-ID ' + clientId}),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                snapshot.data.removeWhere((i) => ((i["images"] != null &&
                        i["images"].length != 0 &&
                        i["images"][0]["type"].contains('mp4')) ||
                    (i["cover"] == null)));
                return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return card(snapshot, index, context);
                    });
              } else
                return Card(child: Text("Pas d'images retrouvées"));
            }),
      ),
    );
  }
}
