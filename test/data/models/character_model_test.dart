import 'dart:convert';

import 'package:flutter_rick_morty/core/exports/exports.dart';
import 'package:flutter_rick_morty/data/models/models.dart';

import '../../test_utils/fixtures/fixture_reader.dart';

void main() {
  late Map<String, dynamic> map;
  setUp(() {
    map = json.decode(fixture('character/single_character.json')) as Map<String, dynamic>;
  });

  test(
    'should make a CharacterModel from json',
    () async {
      // act
      final object = CharacterModel.fromMap(map);
      // assert
      expect(object, isA<CharacterModel>());
      expect(object.id, map['id']);
      //* we should test all properties for an efficient test, but this is just a PoC
    },
  );

  test(
    'should make a json from a CharacterModel',
    () async {
      // arrange
      final object = CharacterModel.fromMap(map);
      // act
      final sut = object.toMap;
      // assert
      expect(sut, isA<Map<String, dynamic>>());
    },
  );

  test(
    'should create a CharacterEntity from CharacterModel',
    () async {
      // arrange
      final object = CharacterModel.fromMap(map);
      // act
      final sut = object.toEntity;
      // assert
      expect(sut, isA());
    },
  );
}
