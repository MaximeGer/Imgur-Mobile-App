import 'package:http/http.dart' as http;
import 'dart:convert';

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
  return gallery["images"][0]["link"].toString();
}


Future<List<dynamic>> fetch(
    String url, Map<String, String> headersParams) async {
  //SharedPreferences prefs = await SharedPreferences.getInstance(); à implémenter plus tard
  var result = await http.get(Uri.parse(url), headers: headersParams);
  if (result.statusCode == 200) {
    return json.decode(result.body)['data'];
  } else {
    return null;
  }
}