import 'package:flutter/material.dart';

// Project imports:
import '../core/env/flavors.dart';
import '../core/exports/app_dependencies.dart';
import '../pages/my_home_page.dart';

// Project imports:

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EquatableConfig.stringify = true;
    return MaterialApp(
      title: AppFlavor.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
