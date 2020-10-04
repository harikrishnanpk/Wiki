import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/wikiInfo.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Wiki',
      routes: {
        '/': (context) => HomePage(),
        'Info': (context) => WikiInfo(),
      },
    );
  }
}
