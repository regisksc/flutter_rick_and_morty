import 'dart:convert';

import 'package:flutter_rick_morty/core/exports/exports.dart';
import 'package:flutter_rick_morty/data/models/models.dart';

import '../../test_utils/fixtures/fixture_reader.dart';

void main() {
  late Map<String, dynamic> map;
  setUp(() {
    map = json.decode(fixture('location/single_location.json')) as Map<String, dynamic>;
  });

  test(
    'should make a LocationModel from json',
    () async {
      // act
      final object = LocationModel.fromMap(map);
      // assert
      expect(object, isA<LocationModel>());
      expect(object.id, map['id']);
      //* we should test all properties for an efficient test, but this is just a PoC
    },
  );

  test(
    'should make a json from a LocationModel',
    () async {
      // arrange
      final object = LocationModel.fromMap(map);
      // act
      final sut = object.toJson;
      // assert
      expect(sut, isA<Map<String, dynamic>>());
    },
  );

  test(
    'should create a LocationEntity from LocationModel',
    () async {
      // arrange
      final object = LocationModel.fromMap(map);
      // act
      final sut = object.toEntity;
      // assert
      expect(sut, isA());
    },
  );
}
