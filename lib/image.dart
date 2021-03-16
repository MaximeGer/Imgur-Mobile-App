import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:epicture/home.dart';

class ImagePage extends StatefulWidget {
  ImagePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final imageList = <Image>[];

  void image() async {
    var response = await http.get(
      Uri.parse(
          'https://api.imgur.com/3/gallery/hot/viral/day/1?showViral=true&mature=true&album_previews=false'),
      headers: {'Authorization': 'Client-ID ' + client_id},
    );

    var repStr = json.decode(response.body);

    Map decoded = json.decode(response.body);

    for (var data in decoded['data']) {
      Image image = new Image(data['id'], data['title'], data['description'],
          data['datetime'], data['type'], data['views'], data['link']);
      imageList.add(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            //color: Color(0xFF141518),
            ),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF1bb76e), // background
                onPrimary: Colors.white, // foreground
                textStyle: TextStyle(fontSize: 18),
                minimumSize: Size(150, 45),
              ),
              onPressed: image,
              child: Text(
                'homeData',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Image {
  String id;
  String title;
  String description;
  int datetime;
  String type;
  int views;
  String link;
  Image(this.id, this.title, this.description, this.datetime, this.type,
      this.views, this.link);
}
