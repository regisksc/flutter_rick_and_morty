import 'package:flutter_rick_morty/pages/my_home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_rick_morty/main_dev.dart' as app;

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