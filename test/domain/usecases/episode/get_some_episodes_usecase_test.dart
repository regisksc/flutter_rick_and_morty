import 'package:flutter_rick_morty/core/domain/errors/failures/base_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';
import 'package:flutter_rick_morty/domain/entities/entities.dart';
import 'package:flutter_rick_morty/domain/repositories/repositories.dart';
import 'package:flutter_rick_morty/domain/usecases/episode/episode.dart';

import '../../../test_utils/mocks/repository_mocks.dart';
import '../../../test_utils/mocks/test_mocks.dart';

void main() {
  late EpisodeRepository repository;
  late GetSomeEpisodesUsecase sut;
  late List<EpisodeEntity> list;
  setUp(() {
    repository = EpisodeRepositoryMock();
    sut = GetSomeEpisodesUsecase(repository);
    list = <EpisodeEntity>[];
  });

  test(
    'should return List<Episode> on success',
    () async {
      // arrange
      when(() => repository.getSome(ids: List.generate(3, (index) => index))).thenAnswer((_) async => Right(list));
      // act
      final result = await sut(List<int>.generate(3, (index) => index));
      final extractedResult = result.fold(id, id);
      // assert
      expect(extractedResult, isA<List<EpisodeEntity>>());
    },
  );

  test(
    'should return Failure when it fails',
    () async {
      // arrange
      when(() => repository.getSome(ids: List.generate(3, (index) => index)))
          .thenAnswer((_) async => Left(FailureMock()));
      // act
      final result = await sut(List<int>.generate(3, (index) => index));
      final extractedResult = result.fold(id, id);
      // assert
      expect(extractedResult, isA<Failure>());
    },
  );
}
