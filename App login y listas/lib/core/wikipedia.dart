// https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&titles=Pet_door&formatversion=2&exsentences=1&exlimit=1&explaintext=1

import 'dart:convert';

import 'package:http/http.dart' as http;

class ArticleIntro {
  ArticleIntro(this.title, this.text);

  String title;
  String? text;
}

class FullArticle {
  FullArticle(this.title, this.html);

  String title;
  String html;
}

Future<List<ArticleIntro?>> getArticleIntros(
  Iterable<String> titles, {
  bool introSection = true,
  int? sentenceCount,
}) async {
  Map<String, String> queryParams = {
    'formatversion': '2',
    'origin': '*',
    'action': 'query',
    'format': 'json',
    'prop': 'extracts',
    'titles': titles.join('|'),
    'explaintext':
        '1', // If this exists it returns HTML, otherwise it returns plain text
    'redirects': '0',
  };

  if (introSection) {
    queryParams['exintro'] = '1';
  }

  if (sentenceCount != null) {
    queryParams['exsentences'] = sentenceCount.toString();
  }

  var url = Uri.https('es.wikipedia.org', 'w/api.php', queryParams);

  var response = await http.get(url);
  Map<String, dynamic>? body = jsonDecode(response.body);
  List? pages = body?['query']['pages'];

  if (pages == null || pages.isEmpty) {
    return Future.error('Pages is empty or null????');
  }

  return pages
      .map((e) => e != null && e['title'] != null && e['title'].isNotEmpty
          ? ArticleIntro(e['title'], e['extract'])
          : null)
      .toList();
}

Future<FullArticle> getFullarticle(String page) async {
  Map<String, String> queryParams = {
    'formatversion': '2',
    'origin': '*',
    'action': 'parse',
    'format': 'json',
    'prop': ['text'].join('|'),
    'page': page,
    'redirects': '1',
    // 'mobileformat': '1',
  };

  var url = Uri.https('es.wikipedia.org', 'w/api.php', queryParams);

  var response = await http.get(url);
  Map<String, dynamic>? body = jsonDecode(response.body);
  Map? data = body?['parse'];

  if (data == null || data.isEmpty) {
    return Future.error('Data is empty or null????');
  }

  if (data['title'] == null || data['title'].isEmpty) {
    return Future.error('Title is empty or null????');
  }

  if (data['text'] == null || data['text'].isEmpty) {
    return Future.error('Text is empty or null????');
  }

  return FullArticle(data['title'], data['text']);
}
