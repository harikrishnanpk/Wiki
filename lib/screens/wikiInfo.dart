import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../model/wikiItem.dart';

class WikiInfo extends StatefulWidget {
  @override
  _WikiInfoState createState() => _WikiInfoState();
}

class _WikiInfoState extends State<WikiInfo> {
  @override
  Widget build(BuildContext context) {
    final Pages item = ModalRoute.of(context).settings.arguments;

    return WebviewScaffold(
      appBar: AppBar(title: Text(item.title)),
      url: 'https://en.wikipedia.org/?curid=' + item.pageid.toString(),
    );
  }
}
