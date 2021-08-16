import 'package:flutter_rick_morty/core/domain/errors/failures/base_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_rick_morty/core/domain/usecase/usecase_abstraction.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';
import 'package:flutter_rick_morty/domain/domain.dart';
import 'package:flutter_rick_morty/domain/entities/entities.dart';
import 'package:flutter_rick_morty/domain/usecases/character/character.dart';

import '../../../test_utils/mocks/repository_mocks.dart';
import '../../../test_utils/mocks/test_mocks.dart';

void main() {
  late CharacterRepository repository;
  late GetAllCharactersUsecase sut;
  late List<Character> list;
  setUp(() {
    repository = CharacterRepositoryMock();
    sut = GetAllCharactersUsecase(repository);
    list = <Character>[];
  });

  test(
    'should return List<Character> on success',
    () async {
      // arrange
      when(() => repository.getAll<Character>()).thenAnswer((_) async => Right(list));
      // act
      final result = await sut(NoParams());
      final extractedResult = result.fold(id, id);
      // assert
      expect(extractedResult, isA<List<Character>>());
    },
  );

  test(
    'should return Failure when it fails',
    () async {
      // arrange
      when(() => repository.getAll<Character>()).thenAnswer((_) async => Left(FailureMock()));
      // act
      final result = await sut(NoParams());
      final extractedResult = result.fold(id, id);
      // assert
      expect(extractedResult, isA<Failure>());
    },
  );
}
