import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:epicture/home.dart';
import 'package:epicture/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagePage extends StatefulWidget {
  ImagePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final imageList = <Image>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<dynamic>>(
            future: fetch(
                'https://api.imgur.com/3/gallery/hot/viral/day/0?showViral=true&mature=true&album_previews=false',
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
                      return Card(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF2c2f34),
                              ),
                              child: Column(children: <Widget>[
                                Image.network(links(snapshot.data[index])),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                    bottom: 5,
                                  ),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Flex(
                                        direction: Axis.vertical,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          IconButton(
                                            icon: const Icon(Icons.message),
                                            color: Color(0xFF8e9094),
                                            iconSize: 24.0,
                                            onPressed: () {},
                                          ),
                                          Text(
                                            comment(snapshot.data[index]),
                                            style: TextStyle(
                                                color: Color(0xFF8e9094)),
                                          )
                                        ],
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.star),
                                        color: Color(0xFF8e9094),
                                        iconSize: 24.0,
                                        onPressed: () {},
                                      ),
                                      Flex(
                                        direction: Axis.vertical,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          IconButton(
                                            icon: const Icon(Icons.favorite),
                                            color: Color(0xFF8e9094),
                                            iconSize: 24.0,
                                            onPressed: () {},
                                          ),
                                          Text(
                                            likes(snapshot.data[index]),
                                            style: TextStyle(
                                                color: Color(0xFF8e9094)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ])));
                    });
              } else
                return Card(child: Text("Pas d'images retrouvées"));
            }),
      ),
    );
  }
}
