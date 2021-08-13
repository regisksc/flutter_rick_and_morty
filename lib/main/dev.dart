// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../core/env/flavors.dart';
import 'app_widget.dart';

void main() {
  AppFlavor.current = Flavor.dev;
  runApp(App());
}
