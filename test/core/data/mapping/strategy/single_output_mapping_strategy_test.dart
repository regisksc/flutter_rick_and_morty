import 'package:flutter_rick_morty/core/data/errors/mapping/mapping.dart';
import 'package:flutter_rick_morty/core/data/mapping/mapping.dart';
import 'package:flutter_rick_morty/core/exports/app_dependencies.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utils/mocks/test_mocks.dart';

void main() {
  late ModelMock model;
  late Map<String, dynamic> map;
  late MappingStrategy sut;

  setUp(() {
    model = ModelMock();
    map = <String, dynamic>{'field': ''};
    sut = SingleOutputMappingStrategy(model.fromMap);
  });

  test(
    'should return needed Object',
    () async {
      // act
      final result = sut<ModelMock>(map) as Either;
      final extractedResult = result.fold(id, id);
      // assert
      expect(extractedResult, isA<ModelMock>());
    },
  );

  test(
    'should throw InvalidMapFailure if input map is not Map<String, dynamic>',
    () async {
      // arrange
      const String invalidMap = '';
      // act
      final result = sut<ModelMock>(invalidMap) as Either;
      final extractedResult = result.fold(id, id);
      // assert
      expect(extractedResult, isA<InvalidMapFailure>());
    },
  );
}
