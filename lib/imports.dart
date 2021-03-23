import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

var clientId = "761207468cb80bd";
var token = "";
var username = "";

String likes(Map<dynamic, dynamic> gallery) {
  if (gallery['ups'] == null) {
    return "0";
  } else if (gallery['ups'] < 1000) {
    return gallery["ups"].toString();
  }
  var likes = (gallery["ups"] / 1000).floor();
  return likes.toString() + "k";
}

String comment(Map<dynamic, dynamic> gallery) {
  if (gallery['comment_count'] == null) {
    return "0";
  } else if (gallery['comment_count'] < 1000) {
    return gallery["comment_count"].toString();
  }
  var likes = (gallery["comment_count"] / 1000).floor();
  return likes.toString() + "k";
}

String links(Map<dynamic, dynamic> gallery) {
  //+ "." + snapshot.data[index]["type"].split("/")[1]
  // return gallery["images"] == null
  //     ? "https://i.imgur.com/${gallery['cover']}.${gallery['type'].split("/")[1]}"
  //     : gallery["images"][0]["link"].toString();
  print("gallery:$gallery");
  if (gallery["images"] == null) {
    if (gallery['cover'] == null) {
      print(gallery["link"].toString());
      return gallery["link"].toString();
    } else {
      return "https://i.imgur.com/${gallery['cover']}.${gallery['type'].split("/")[1]}";
    }
  } else {
    return gallery["images"][0]["link"].toString();
  }
}

Future<List<dynamic>> fetch(
    String url, Map<String, String> headersParams) async {
  //SharedPreferences prefs = await SharedPreferences.getInstance(); à implémenter plus tard
  var result = await http.get(Uri.parse(url), headers: headersParams);
  if (result.statusCode == 200) {
    return json.decode(result.body)['data'];
  } else {
    return ["ErrorCode : ${result.statusCode}"];
  }
}

String getId(Map<dynamic, dynamic> gallery) {
  if (gallery["images"] == null) {
    if (gallery['cover'] == null) {
      print(gallery["id"].toString());
      return gallery["id"].toString();
    } else {
      return gallery['cover'];
    }
  } else {
    return gallery["images"][0]["id"].toString();
  }
}

Future<String> favoris(
    String imageHash, Map<String, String> headersParams) async {
  var result = await http.post(
      Uri.parse('https://api.imgur.com/3/image/$imageHash/favorite'),
      headers: headersParams);
  return (json.decode(result.body)['data']);
}

Widget card(AsyncSnapshot<dynamic> snapshot, int index, BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.message),
                        color: Color(0xFF8e9094),
                        iconSize: 24.0,
                        onPressed: () {},
                      ),
                      Text(
                        comment(snapshot.data[index]),
                        style: TextStyle(color: Color(0xFF8e9094)),
                      )
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    color: Color(0xFF8e9094),
                    iconSize: 24.0,
                    onPressed: () async {
                      if (token.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Essayez de vous connecter pour l'ajouter à vos favoris"),
                        ));
                      } else {
                        var etatfavoris = await favoris(
                            getId(snapshot.data[index]),
                            {"Authorization": "Bearer $token"});
                        if (etatfavoris == "favorited") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Ajout de l'image aux favoris"),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Suppresion du favori"),
                          ));
                        }
                      }
                    },
                  ),
                  Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_upward),
                        color: Color(0xFF8e9094),
                        iconSize: 24.0,
                        onPressed: () {},
                      ),
                      Text(
                        likes(snapshot.data[index]),
                        style: TextStyle(color: Color(0xFF8e9094)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ])));
}
