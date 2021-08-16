import 'package:flutter_rick_morty/core/exports/exports.dart';
import '../../../../lib/core/resources/extensions/list_extensions.dart';

void main() {
  test(
    'should conver a list of int into a list of String form numbers',
    () async {
      // arrange
      final listOfIntegers = List<int>.generate(3, (i) => i * i * i);
      // act
      final listOfStringifiedNumbers = listOfIntegers.stringifyMembers;
      // assert
      expect(listOfStringifiedNumbers, isA<List<String>>());
    },
  );
}
