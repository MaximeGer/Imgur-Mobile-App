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

String links(Map<dynamic, dynamic> gallery) {
  //+ "." + snapshot.data[index]["type"].split("/")[1]
  return gallery["images"] == null
      ? "https://i.imgur.com/${gallery['cover']}.${gallery['type'].split("/")[1]}"
      : gallery["images"][0]["link"].toString();
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
