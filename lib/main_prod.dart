// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'app.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.prod;
  runApp(App());
}
