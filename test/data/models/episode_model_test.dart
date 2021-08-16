import 'dart:convert';

import 'package:flutter_rick_morty/core/exports/exports.dart';
import 'package:flutter_rick_morty/data/models/models.dart';
import 'package:flutter_rick_morty/domain/domain.dart';

import '../../test_utils/fixtures/fixture_reader.dart';

void main() {
  late Map<String, dynamic> map;
  setUp(() {
    map = json.decode(fixture('episode/single_episode.json')) as Map<String, dynamic>;
  });

  test(
    'should make a EpisodeModel from json',
    () async {
      // act
      final object = EpisodeModel.fromMap(map);
      // assert
      expect(object, isA<EpisodeModel>());
      expect(object.id, map['id']);
      //* we should test all properties for an efficient test, but this is just a PoC
    },
  );

  test(
    'should make a json from a EpisodeModel',
    () async {
      // arrange
      final object = EpisodeModel.fromMap(map);
      // act
      final sut = object.toMap;
      // assert
      expect(sut, isA<Map<String, dynamic>>());
    },
  );

  test(
    'should create a Episode from EpisodeModel',
    () async {
      // arrange
      final object = EpisodeModel.fromMap(map);
      // act
      final sut = object.toEntity;
      // assert
      expect(sut, isA<EpisodeEntity>());
    },
  );
}
