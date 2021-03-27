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
      appBar: AppBar(
        backgroundColor: Color(0xFF1bb76e),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
            future: fetch(
                "https://api.imgur.com/3/account/$username/favorites/0/newest",
                {"Authorization": "Bearer $token"}),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && token.isNotEmpty) {
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
                return Card(
                    child: Text("Pas d'images retrouvées. Connectez-vous!!!"));
            }),
      ),
    );
  }
}
