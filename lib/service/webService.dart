import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/wikiItem.dart';

class WebService {
  Future<WikiItem> loadWikiPages() async {
    String url =
        'https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=100&pilimit=10&wbptterms=description&gpssearch=Sachin+T&gpslimit=10';

    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return WikiItem.fromJson(json);
    } else {
      throw Exception('Erro in loading wiki');
    }
  }
}
