// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../core/env/flavors.dart';
import 'app_widget.dart';
import 'run_app_command.dart';

Future<void> main() async {
  AppFlavor.current = Flavor.prod;
  await setUpAndRunApp();
}
