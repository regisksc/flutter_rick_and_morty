// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:flutter_rick_morty/core/data/datasources/local/local_datasource.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';
import '../../../../test_utils/constants/data_type_test_constants.dart';

class StorageMock extends Mock implements GetStorage {}

void main() {
  late StorageMock storageMock;
  late LocalDatasource sut;
  setUp(() {
    storageMock = StorageMock();
    sut = LocalDatasource(storageMock);
  });

  test(
    'should properly save data',
    () async {
      // arrange
      final key = faker.lorem.word();
      final value = json.encode(anyMap);
      when(() => storageMock.write(key, value)).thenAnswer((_) => Future.value());

      // act
      sut.save(key: key, value: value);

      // assert
      verify(() => storageMock.write(key, value));
    },
  );

  test(
    'should properly retrieve data',
    () async {
      // arrange
      final key = faker.lorem.word();
      final value = json.encode(anyMap);
      when(() => storageMock.hasData(key)).thenReturn(true);
      when(() => storageMock.read(key)).thenReturn(value);

      // act
      final result = await sut.read(key);

      // assert
      verify(() => storageMock.hasData(key));
      verify(() => storageMock.read(key));
      expect(result, equals(value));
    },
  );
}
