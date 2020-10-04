import 'package:flutter/material.dart';
import 'package:mywiki/screens/wikiInfo.dart';
import 'package:mywiki/service/webService.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/wikiItem.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<WikiItem> wikiItem;

  @override
  void initState() {
    super.initState();
    _loadWikiPages();
  }

  void _loadWikiPages() {
    wikiItem = WebService().loadWikiPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wiki'),
      ),
      body: FutureBuilder<WikiItem>(
          future: wikiItem,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return _buildListView(snapShot.data);
            } else if (snapShot.hasError) {
              return Text('No Data');
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget _buildListView(WikiItem model) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final item = model.query.pages[index];

        return Container(
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WikiInfo(),
                    settings: RouteSettings(arguments: item)),
              );
            },
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    child: userIcon(item.thumbnail),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              getTerms(item.terms),
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: model.query.pages.length,
    );
  }

  Widget userIcon(Thumbnail thumbnail) {
    if (thumbnail != null) {
      return FadeInImage.memoryNetwork(
          height: 100,
          width: 100,
          placeholder: kTransparentImage,
          image: thumbnail.source);
    } else {
      return Image.asset(
        'images/user.png',
        height: 100,
        width: 100,
      );
    }
  }

  String getTerms(Terms terms) {
    if (terms == null) {
      return '';
    } else {
      return terms.description.join(',');
    }
  }
}
