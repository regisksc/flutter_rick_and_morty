import 'package:flutter_rick_morty/core/data/errors/mapping/mapping.dart';
import 'package:flutter_rick_morty/core/data/mapping/mapping.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';

import '../../../../test_utils/mocks/test_mocks.dart';

void main() {
  late ModelMock model;
  late Map<String, dynamic> map;
  late List list;
  late MappingStrategy sut;

  setUp(() {
    model = ModelMock();
    map = <String, dynamic>{'field': ''};
    list = [];
    for (int i = 0; i < 2; i++) {
      list.add(Map<String, dynamic>.from(map));
    }
    sut = MultipleOutputMappingStrategy(model.fromMap);
  });

  test(
    'should return a list of needed Object',
    () async {
      // act
      final result = sut<ModelMock>(list);
      final extractedResult = result.fold((failure) => failure, (resultList) => resultList);

      // assert
      expect(extractedResult, [
        ModelMock().fromMap(map),
        ModelMock().fromMap(map),
      ]);
    },
  );

  test(
    'should return InvalidMapFailure if input map is not List<Map<String, dynamic>>',
    () async {
      // arrange
      const invalidMap = ['', false, 1];

      // act
      final result = sut<ModelMock>(invalidMap);
      final extractedResult = result.fold((failure) => failure, (resultList) => resultList);

      // assert
      expect(extractedResult, isA<InvalidMapFailure>());
    },
  );
}
