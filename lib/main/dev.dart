// Project imports:
import '../core/env/flavors.dart';
import '../core/exports/exports.dart';
import 'run_app_command.dart';

Future<void> main() async {
  AppFlavor.current = Flavor.dev;
  await setUpAndRunApp();
}
