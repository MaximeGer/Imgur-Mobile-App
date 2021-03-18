import 'package:epicture/imports.dart';
import 'package:flutter/material.dart';

class FavorisPage extends StatefulWidget {
  FavorisPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FavorisPageState createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
            future: fetch(
                "https://api.imgur.com/3/account/$username/favorites/0/newest",
                {"Authorization": "Bearer $token"}),
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
