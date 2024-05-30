// https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&titles=Pet_door&formatversion=2&exsentences=1&exlimit=1&explaintext=1

import 'dart:convert';

import 'package:http/http.dart' as http;

class Article {
  late String title;
  late String text;
}

Future<(String, String)?> getArticles(
  List<String> titles, {
  bool introSection = false,
  int? sentenceCount,
}) async {
  var queryParams = {
    'action': 'query',
    'format': 'json',
    'prop': 'extracts',
    'titles': titles.join(','),
    'formatversion': 2,
    'exintro': introSection ? 1 : 0,
    'explaintext': 1 // 1 means Markdown, 0 means HTML
  };

  if (sentenceCount != null) {
    queryParams["exsentences"] = sentenceCount;
  }

  var url = Uri.https('es.wikipedia.org', 'w/api.php', queryParams);

  var response = await http.get(url);
  Map<String, dynamic> body = jsonDecode(response.body);

  if (body["pages"] == null || (body["pages"] as List).isEmpty) {
    return null;
  }

  if (body["pages"][0]["title"] == null) {
    return null;
  }

  (String, String) data = (body["pages"][0]["title"], body["pages"][0]["extract"] ?? "");

  return data;
}
