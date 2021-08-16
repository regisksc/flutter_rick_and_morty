import 'package:flutter_rick_morty/data/models/models.dart';
import 'package:flutter_rick_morty/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'should conver a Location into a CharacterModel',
    () async {
      // arrange
      final entity = Location(
        id: 1,
        residentsIds: const [1],
        name: 'name',
        type: 'type',
        dimension: 'dimension',
      );

      // act
      final model = entity.toModel;

      // assert
      expect(model, isA<LocationModel>());
    },
  );
}
