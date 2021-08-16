import 'package:flutter_rick_morty/core/domain/errors/failures/base_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_rick_morty/core/domain/usecase/usecase_abstraction.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';
import 'package:flutter_rick_morty/domain/domain.dart';
import 'package:flutter_rick_morty/domain/entities/entities.dart';
import 'package:flutter_rick_morty/domain/usecases/location/location.dart';

import '../../../test_utils/mocks/repository_mocks.dart';
import '../../../test_utils/mocks/test_mocks.dart';

void main() {
  late LocationRepository repository;
  late GetAllLocationsUsecase sut;
  late List<Location> list;
  setUp(() {
    repository = LocationRepositoryMock();
    sut = GetAllLocationsUsecase(repository);
    list = <Location>[];
  });

  test(
    'should return List<Location> on success',
    () async {
      // arrange
      when(() => repository.getAll<Location>()).thenAnswer((_) async => Right(list));
      // act
      final result = await sut(NoParams());
      final extractedResult = result.fold(id, id);
      // assert
      expect(extractedResult, isA<List<Location>>());
    },
  );

  test(
    'should return Failure when it fails',
    () async {
      // arrange
      when(() => repository.getAll<Location>()).thenAnswer((_) async => Left(FailureMock()));
      // act
      final result = await sut(NoParams());
      final extractedResult = result.fold(id, id);
      // assert
      expect(extractedResult, isA<Failure>());
    },
  );
}
