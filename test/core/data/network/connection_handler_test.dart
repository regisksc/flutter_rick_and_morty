import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter_rick_morty/core/data/network/network.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDataConnectionHandler extends Mock implements DataConnectionChecker {}

void main() {
  late DataConnectionChecker connection;
  late ConnectionHandler sut;
  setUp(() {
    connection = MockDataConnectionHandler();
    sut = ConnectionHandler(connection);
  });
  test(
    'should return true when connected to network',
    () async {
      // arrange
      when(() => connection.hasConnection).thenAnswer((_) async => true);
      // act
      final hasConnection = await sut.hasConnection;
      // assert
      expect(hasConnection, equals(true));
    },
  );

  test(
    'should return false when NOT connected to network',
    () async {
      // arrange
      when(() => connection.hasConnection).thenAnswer((_) async => false);
      // act
      final hasConnection = await sut.hasConnection;
      // assert
      expect(hasConnection, equals(false));
    },
  );
}
