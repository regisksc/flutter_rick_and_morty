import 'package:flutter_rick_morty/core/domain/errors/failures/base_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';
import 'package:flutter_rick_morty/domain/entities/entities.dart';
import 'package:flutter_rick_morty/domain/repositories/repositories.dart';
import 'package:flutter_rick_morty/domain/usecases/character/character.dart';

import '../../../test_utils/mocks/repository_mocks.dart';
import '../../../test_utils/mocks/test_mocks.dart';

void main() {
  late CharacterRepository repository;
  late GetSomeCharactersUsecase sut;
  late List<CharacterEntity> list;
  setUp(() {
    repository = CharacterRepositoryMock();
    sut = GetSomeCharactersUsecase(repository);
    list = <CharacterEntity>[];
  });

  test(
    'should return List<Character> on success',
    () async {
      // arrange
      when(() => repository.getSome<CharacterEntity>()).thenAnswer((_) async => Right(list));
      // act
      final result = await sut(List<int>.generate(3, (index) => index));
      final extractedResult = result.fold(id, id);
      // assert
      expect(extractedResult, isA<List<CharacterEntity>>());
    },
  );

  test(
    'should return Failure when it fails',
    () async {
      // arrange
      when(() => repository.getSome<CharacterEntity>()).thenAnswer((_) async => Left(FailureMock()));
      // act
      final result = await sut(List<int>.generate(3, (index) => index));
      final extractedResult = result.fold(id, id);
      // assert
      expect(extractedResult, isA<Failure>());
    },
  );
}
