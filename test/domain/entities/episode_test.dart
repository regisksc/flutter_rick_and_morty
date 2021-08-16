import 'package:flutter_rick_morty/data/models/models.dart';
import 'package:flutter_rick_morty/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'should conver a Episode into a CharacterModel',
    () async {
      // arrange
      final entity = Episode(
        id: 1,
        characterIds: const [1],
        name: 'name',
        airDate: 'airDate',
        episode: 'episode',
      );
      // act
      final model = entity.toModel;
      // assert
      expect(model, isA<EpisodeModel>());
    },
  );
}
