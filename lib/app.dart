// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'flavors.dart';
import 'pages/my_home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: F.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
