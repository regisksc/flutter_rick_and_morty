import 'dart:convert';

import 'package:flutter_rick_morty/core/data/data.dart';
import 'package:flutter_rick_morty/core/data/datasources/datasources.dart';
import 'package:flutter_rick_morty/core/domain/errors/failures/no_connection_failure.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';
import 'package:flutter_rick_morty/core/resources/constants/storage_keys.dart';
import 'package:flutter_rick_morty/data/models/models.dart';
import 'package:flutter_rick_morty/data/repositories/repositories.dart';
import 'package:flutter_rick_morty/domain/domain.dart';

import '../../test_utils/constants/data_type_test_constants.dart';
import '../../test_utils/fixtures/fixture_reader.dart';
import '../../test_utils/mocks/datasource_mocks.dart';
import '../../test_utils/mocks/test_mocks.dart';

void main() {
  late RemoteDatasource remoteDatasource;
  late LocalDatasource localDatasource;
  late ConnectionHandler connectionHandler;
  late CharacterRepository sut;
  late CharacterModel model;
  late List fixtureJson;
  late List<int> idsToLookUp;

  setUp(() {
    remoteDatasource = RemoteDatasourceMock();
    localDatasource = LocalDatasourceMock();
    connectionHandler = ConnectionHandlerMock();
    sut = CharacterRepositoryImpl(
      remoteDataSource: remoteDatasource,
      localDataSource: localDatasource,
      connectionHandler: connectionHandler,
    );
    model = CharacterModel(
      featuredEpisodeIds: const [1],
      lastLocationId: 1,
      originaryLocationId: 1,
      id: 1,
      name: 'name',
      status: 'status',
      species: 'species',
      type: 'type',
      gender: 'gender',
      image: 'image',
    );
    fixtureJson = json.decode(fixture('character/many_characters.json')) as List;
  });

  group('Get all Characters', () {
    late HttpRequestParams httpParams;
    setUpAll(() {
      httpParams = HttpRequestParams(
        httpMethod: HttpMethod.get,
        endpoint: makeApiUrl('character'),
        queryParameters: mockQuery,
      );
      registerFallbackValue(httpParams);
    });
    test(
      'should get all Characters from api',
      () async {
        // arrange
        when(() => connectionHandler.hasConnection).thenAnswer((_) async => true);
        when(
          () => remoteDatasource.fetchMoreThanOneOutput<CharacterModel>(
              httpParams: httpParams, modelSerializer: CharacterModel.fromMap),
        ).thenAnswer((_) async => Right([model]));
        // act
        final result = await sut.getAll();
        final extractedResult = result.fold(id, id);
        // assert
        verifyNever(() => localDatasource.read(any()));
        verifyInOrder([
          () => connectionHandler.hasConnection,
          () =>
              remoteDatasource.fetchMoreThanOneOutput(httpParams: httpParams, modelSerializer: CharacterModel.fromMap),
        ]);
        expect(extractedResult, isA<List<CharacterEntity>>());
      },
    );

    test(
      'should get all Characters from local storage',
      () async {
        // arrange
        when(() => connectionHandler.hasConnection).thenAnswer((_) async => false);
        when(
          () => localDatasource.read(any()),
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
          () => localDatasource.read(any()),
        ]);
        expect(extractedResult, isA<List<CharacterEntity>>());
      },
    );
  });

  group('Get some Characters', () {
    late HttpRequestParams httpParams;
    setUpAll(() {
      idsToLookUp = List<int>.generate(3, (_) => faker.randomGenerator.integer(500));
      registerFallbackValue(idsToLookUp);
      httpParams = HttpRequestParams(
        httpMethod: HttpMethod.get,
        endpoint: makeApiUrl('character/${idsToLookUp.toString()}'),
      );
      registerFallbackValue(httpParams);
    });
    test(
      'should get some Characters from api',
      () async {
        // arrange
        when(() => connectionHandler.hasConnection).thenAnswer((_) async => true);
        when(
          () => remoteDatasource.fetchMoreThanOneOutput<CharacterModel>(
            httpParams: any(named: 'httpParams'),
            modelSerializer: CharacterModel.fromMap,
          ),
        ).thenAnswer((_) async => Right([model]));
        // act
        final result = await sut.getSome(ids: idsToLookUp);
        final extractedResult = result.fold(id, id);
        // assert
        verifyNever(() => localDatasource.read(any()));
        verifyInOrder([
          () => connectionHandler.hasConnection,
          () =>
              remoteDatasource.fetchMoreThanOneOutput(httpParams: httpParams, modelSerializer: CharacterModel.fromMap),
        ]);
        expect(extractedResult, isA<List<CharacterEntity>>());
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
