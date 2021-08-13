// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../core/env/flavors.dart';
import '../pages/my_home_page.dart';

// Project imports:

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppFlavor.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
