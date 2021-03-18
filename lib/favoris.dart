import 'dart:convert';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:epicture/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/login.dart';

class FavorisPage extends StatefulWidget {
  FavorisPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FavorisPageState createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
  Future<List<dynamic>> fetchGalleries(
      Map<String, String> requestKeys, Map<String, String> queries) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = requestKeys["section"] +
        "/" +
        requestKeys["sort"] +
        "/" +
        requestKeys["window"] +
        "/" +
        requestKeys["page"];

    var result = await http.get(
        Uri.parse(
            'https://api.imgur.com/3/gallery/hot/viral/day/1?showViral=true&mature=true&album_previews=false'),
        headers: {"Authorization": 'Client-ID ' + client_id});

    if (result.statusCode == 200) {
      return json.decode(result.body)['data'];
    } else {
      return null;
    }
  }

  String _likes(Map<dynamic, dynamic> gallery) {
    if (gallery['ups'] == null) {
      return "0";
    } else if (gallery['ups'] < 1000) {
      return gallery["ups"].toString();
    }
    var likes = (gallery["ups"] / 1000).floor();
    return likes.toString() + "k";
  }

  String _images(Map<dynamic, dynamic> gallery) {
    //var imageLink = gallery["images"]["link"];
    //print();
    return gallery["images"][0]["link"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoris Image'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
            future: fetchGalleries({
              "section": "hot",
              "sort": "viral",
              "window": "day",
              "page": "1"
            }, {
              "showViral": "true",
              "mature": "true",
              "album_previews": "false"
            }),
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
                                Image.network(_images(snapshot.data[index])),
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
                                      IconButton(
                                        icon: const Icon(Icons.message),
                                        color: Color(0xFF8e9094),
                                        iconSize: 24.0,
                                        onPressed: () {},
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
                                            _likes(snapshot.data[index]),
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
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//           //color: Color(0xFF141518),
//           ),
//       child: Column(
//         children: <Widget>[
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Color(0xFF1bb76e), // background
//               onPrimary: Colors.white, // foreground
//               textStyle: TextStyle(fontSize: 18),
//               minimumSize: Size(150, 45),
//             ),
//             onPressed: image,
//             child: Text(
//               'homeData',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Image {
//   String id;
//   String title;
//   String description;
//   int datetime;
//   String type;
//   int views;
//   String link;
//   Image(this.id, this.title, this.description, this.datetime, this.type,
//       this.views, this.link);
// }
