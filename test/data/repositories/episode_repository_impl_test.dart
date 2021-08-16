import 'dart:convert';

import 'package:flutter_rick_morty/core/data/data.dart';
import 'package:flutter_rick_morty/core/data/datasources/datasources.dart';
import 'package:flutter_rick_morty/core/domain/errors/failures/no_connection_failure.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';
import 'package:flutter_rick_morty/core/resources/constants/storage_keys.dart';
import 'package:flutter_rick_morty/data/models/models.dart';
import 'package:flutter_rick_morty/data/repositories/episode_repository_impl.dart';
import 'package:flutter_rick_morty/domain/domain.dart';
import 'package:flutter_rick_morty/domain/repositories/episode_repository.dart';

import '../../test_utils/fixtures/fixture_reader.dart';
import '../../test_utils/mocks/datasource_mocks.dart';
import '../../test_utils/mocks/test_mocks.dart';

void main() {
  late RemoteDatasource remoteDatasource;
  late LocalDatasource localDatasource;
  late ConnectionHandler connectionHandler;
  late EpisodeRepository sut;
  late EpisodeModel model;
  late List fixtureJson;
  late List<int> idsToLookUp;

  setUp(() {
    remoteDatasource = RemoteDatasourceMock();
    localDatasource = LocalDatasourceMock();
    connectionHandler = ConnectionHandlerMock();
    sut = EpisodeRepositoryImpl(
      remoteDataSource: remoteDatasource,
      localDataSource: localDatasource,
      connectionHandler: connectionHandler,
    );
    model = EpisodeModel(
      id: faker.randomGenerator.integer(100),
      characterIds: [faker.randomGenerator.integer(100)],
      name: faker.lorem.sentence(),
      airDate: '',
      episode: '',
    );
    fixtureJson = json.decode(fixture('episode/many_episodes.json')) as List;
  });

  group('Get all Episodes', () {
    late HttpRequestParams httpParams;
    setUpAll(() {
      httpParams = HttpRequestParams(httpMethod: HttpMethod.get, endpoint: makeApiUrl('episode'));
      registerFallbackValue(httpParams);
    });
    test(
      'should get all Episodes from api',
      () async {
        // arrange
        when(() => connectionHandler.hasConnection).thenAnswer((_) async => true);
        when(
          () => remoteDatasource.fetchMoreThanOneOutput<EpisodeModel>(
              httpParams: httpParams, modelSerializer: EpisodeModel.fromMap),
        ).thenAnswer((_) async => Right([model]));
        // act
        final result = await sut.getAll();
        final extractedResult = result.fold(id, id);
        // assert
        verifyNever(() => localDatasource.read(any()));
        verifyInOrder([
          () => connectionHandler.hasConnection,
          () => remoteDatasource.fetchMoreThanOneOutput(httpParams: httpParams, modelSerializer: EpisodeModel.fromMap),
        ]);
        expect(extractedResult, isA<List<EpisodeEntity>>());
      },
    );

    test(
      'should get all Episodes from local storage',
      () async {
        // arrange
        when(() => connectionHandler.hasConnection).thenAnswer((_) async => false);
        when(
          () => localDatasource.read(StorageKeys.episodeKey),
        ).thenAnswer((_) async => json.encode(fixtureJson));
        // act
        final result = await sut.getAll();
        final extractedResult = result.fold(id, id);
        // assert
        verifyNever(
          () => remoteDatasource.fetchMoreThanOneOutput(
            httpParams: any(named: 'httpParams'),
            modelSerializer: any(named: 'modelSerializer'),
          ),
        );
        verifyInOrder([
          () => connectionHandler.hasConnection,
          () => localDatasource.read(StorageKeys.episodeKey),
        ]);
        expect(extractedResult, isA<List<EpisodeEntity>>());
      },
    );
  });

  group('Get some Episodes', () {
    late HttpRequestParams httpParams;
    setUpAll(() {
      idsToLookUp = List<int>.generate(3, (_) => faker.randomGenerator.integer(500));
      registerFallbackValue(idsToLookUp);
      httpParams = HttpRequestParams(
        httpMethod: HttpMethod.get,
        endpoint: makeApiUrl('episode/${idsToLookUp.toString()}'),
      );
      registerFallbackValue(httpParams);
    });
    test(
      'should get some Episodes from api',
      () async {
        // arrange
        when(() => connectionHandler.hasConnection).thenAnswer((_) async => true);
        when(
          () => remoteDatasource.fetchMoreThanOneOutput<EpisodeModel>(
            httpParams: any(named: 'httpParams'),
            modelSerializer: EpisodeModel.fromMap,
          ),
        ).thenAnswer((_) async => Right([model]));
        // act
        final result = await sut.getSome(ids: idsToLookUp);
        final extractedResult = result.fold(id, id);
        // assert
        verifyNever(() => localDatasource.read(any()));
        verifyInOrder([
          () => connectionHandler.hasConnection,
          () => remoteDatasource.fetchMoreThanOneOutput(httpParams: httpParams, modelSerializer: EpisodeModel.fromMap),
        ]);
        expect(extractedResult, isA<List<EpisodeEntity>>());
      },
    );

    test(
      'should return a NoConnectionFailure when disconnected',
      () async {
        // arrange
        when(() => connectionHandler.hasConnection).thenAnswer((_) async => false);
        // act
        final result = await sut.getSome(ids: idsToLookUp);
        final extractedResult = result.fold(id, id);
        // assert
        verifyNever(
          () => remoteDatasource.fetchMoreThanOneOutput(
            httpParams: any(named: 'httpParams'),
            modelSerializer: any(named: 'modelSerializer'),
          ),
        );
        verifyNever(() => localDatasource.read(StorageKeys.episodeKey));
        expect(extractedResult, isA<NoConnectionFailure>());
      },
    );
  });
}
