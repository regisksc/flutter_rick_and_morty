// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// Project imports:
import 'package:flutter_rick_morty/main/dev.dart' as app;
import 'package:flutter_rick_morty/pages/my_home_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    '''
    WHEN app launches
    SHOULD show the MyHomePage
    ''',
    (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final myHomePage = find.byType(MyHomePage);
      expect(myHomePage, findsOneWidget);
    },
  );
}
