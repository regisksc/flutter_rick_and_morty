import 'package:flutter_rick_morty/data/models/models.dart';
import 'package:flutter_rick_morty/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'should conver a Character into a CharacterModel',
    () async {
      // arrange
      final entity = Character(
        lastLocationId: 1,
        originaryLocationId: 1,
        featuredEpisodeIds: const [1],
        id: 1,
        name: 'name',
        status: 'status',
        species: 'species',
        type: 'type',
        gender: 'gender',
        image: 'image',
      );

      // act
      final model = entity.toModel;

      // assert
      expect(model, isA<CharacterModel>());
    },
  );
}
