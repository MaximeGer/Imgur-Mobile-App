import 'package:http/http.dart' as http;
import 'dart:convert';

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
