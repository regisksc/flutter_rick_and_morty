import 'package:flutter/material.dart';

// Project imports:
import '../core/env/flavors.dart';
import '../core/exports/app_dependencies.dart';
import '../core/resources/constants/constants.dart';
import '../presentation/presentation.dart';

// Project imports:

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EquatableConfig.stringify = true;
    return MaterialApp(
      title: AppFlavor.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.green[700],
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            fontSize: 14,
          ),
          subtitle1: const TextStyle(
            color: AppColors.lightGreenAcc,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            fontSize: 11,
          ),
          bodyText1: const TextStyle(
            color: AppColors.greenAcc,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            fontSize: 10,
          ),
        ),
      ),
      home: const CharacterListPage(),
    );
  }
}
