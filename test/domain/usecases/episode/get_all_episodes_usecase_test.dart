import 'package:flutter_rick_morty/core/domain/errors/failures/base_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_rick_morty/core/domain/usecase/usecase_abstraction.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';
import 'package:flutter_rick_morty/domain/entities/entities.dart';
import 'package:flutter_rick_morty/domain/repositories/repositories.dart';
import 'package:flutter_rick_morty/domain/usecases/episode/episode.dart';

import '../../../test_utils/mocks/repository_mocks.dart';
import '../../../test_utils/mocks/test_mocks.dart';

void main() {
  late EpisodeRepository repository;
  late GetAllEpisodesUsecase sut;
  late List<Episode> list;
  setUp(() {
    repository = EpisodeRepositoryMock();
    sut = GetAllEpisodesUsecase(repository);
    list = <Episode>[];
  });

  test(
    'should return List<Episode> on success',
    () async {
      // arrange
      when(() => repository.getAll<Episode>()).thenAnswer((_) async => Right(list));
      // act
      final result = await sut(NoParams());
      final extractedResult = result.fold(id, id);
      // assert
      expect(extractedResult, isA<List<Episode>>());
    },
  );

  test(
    'should return Failure when it fails',
    () async {
      // arrange
      when(() => repository.getAll<Episode>()).thenAnswer((_) async => Left(FailureMock()));
      // act
      final result = await sut(NoParams());
      final extractedResult = result.fold(id, id);
      // assert
      expect(extractedResult, isA<Failure>());
    },
  );
}
