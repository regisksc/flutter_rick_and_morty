// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../core/exports/app_dependencies.dart';
import 'app_widget.dart';

Future<void> setUpAndRunApp() async {
  await GetStorage.init();
  runApp(App());
}
