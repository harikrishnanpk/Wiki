import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/wikiItem.dart';
import 'package:json_store/json_store.dart';

class WebService {
  Future<WikiItem> loadWikiPages() async {
    String url =
        'https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=100&pilimit=10&wbptterms=description&gpssearch=Sachin+T&gpslimit=10';

    try {
      final response = await http.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        // Save Data to JsonStore
        JsonStore().setItem('wikiItems', json);
        return WikiItem.fromJson(json);
      } else {
        throw Exception('Erro in loading wiki');
      }
    } on SocketException catch (_) {
      // Get Data From JsonStore
      Map<String, dynamic> json = await JsonStore().getItem('wikiItems');
      if (json != null) {
        return WikiItem.fromJson(json);
      } else {
        throw Exception('No Data in DB');
      }
    }
  }
}
