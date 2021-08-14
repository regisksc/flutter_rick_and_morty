import 'package:flutter/material.dart';
import '../core/env/flavors.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppFlavor.title),
      ),
      body: Center(
        child: Text(
          'Hello ${AppFlavor.title}',
        ),
      ),
    );
  }
}
