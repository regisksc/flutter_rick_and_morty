import 'dart:convert';

import 'package:flutter_rick_morty/core/data/data.dart';
import 'package:flutter_rick_morty/core/data/datasources/datasources.dart';
import 'package:flutter_rick_morty/core/domain/errors/failures/no_connection_failure.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';
import 'package:flutter_rick_morty/core/resources/constants/storage_keys.dart';
import 'package:flutter_rick_morty/data/models/models.dart';
import 'package:flutter_rick_morty/data/repositories/repositories.dart';
import 'package:flutter_rick_morty/domain/domain.dart';

import '../../test_utils/fixtures/fixture_reader.dart';
import '../../test_utils/mocks/datasource_mocks.dart';
import '../../test_utils/mocks/test_mocks.dart';

void main() {
  late RemoteDatasource remoteDatasource;
  late LocalDatasource localDatasource;
  late ConnectionHandler connectionHandler;
  late LocationRepository sut;
  late LocationModel model;
  late List fixtureJson;
  late List<int> idsToLookUp;

  setUp(() {
    remoteDatasource = RemoteDatasourceMock();
    localDatasource = LocalDatasourceMock();
    connectionHandler = ConnectionHandlerMock();
    sut = LocationRepositoryImpl(
      remoteDataSource: remoteDatasource,
      localDataSource: localDatasource,
      connectionHandler: connectionHandler,
    );
    model = LocationModel(
      id: 1,
      residentsIds: const [1],
      name: 'name',
      type: 'type',
      dimension: 'dimension',
    );
    fixtureJson = json.decode(fixture('location/many_locations.json')) as List;
  });

  group('Get all Locations', () {
    late HttpRequestParams httpParams;
    setUpAll(() {
      httpParams = HttpRequestParams(httpMethod: HttpMethod.get, endpoint: makeApiUrl('location'));
      registerFallbackValue(httpParams);
    });
    test(
      'should get all Locations from api',
      () async {
        // arrange
        when(() => connectionHandler.hasConnection).thenAnswer((_) async => true);
        when(
          () => remoteDatasource.fetchMoreThanOneOutput<LocationModel>(
              httpParams: httpParams, modelSerializer: LocationModel.fromMap),
        ).thenAnswer((_) async => Right([model]));
        // act
        final result = await sut.getAll();
        final extractedResult = result.fold(id, id);
        // assert
        verifyNever(() => localDatasource.read(any()));
        verifyInOrder([
          () => connectionHandler.hasConnection,
          () => remoteDatasource.fetchMoreThanOneOutput(httpParams: httpParams, modelSerializer: LocationModel.fromMap),
        ]);
        expect(extractedResult, isA<List<LocationEntity>>());
      },
    );

    test(
      'should get all Locations from local storage',
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
        expect(extractedResult, isA<List<LocationEntity>>());
      },
    );
  });

  group('Get some Locations', () {
    late HttpRequestParams httpParams;
    setUpAll(() {
      idsToLookUp = List<int>.generate(3, (_) => faker.randomGenerator.integer(500));
      registerFallbackValue(idsToLookUp);
      httpParams = HttpRequestParams(
        httpMethod: HttpMethod.get,
        endpoint: makeApiUrl('location/${idsToLookUp.toString()}'),
      );
      registerFallbackValue(httpParams);
    });
    test(
      'should get some Locations from api',
      () async {
        // arrange
        when(() => connectionHandler.hasConnection).thenAnswer((_) async => true);
        when(
          () => remoteDatasource.fetchMoreThanOneOutput<LocationModel>(
            httpParams: any(named: 'httpParams'),
            modelSerializer: LocationModel.fromMap,
          ),
        ).thenAnswer((_) async => Right([model]));
        // act
        final result = await sut.getSome(ids: idsToLookUp);
        final extractedResult = result.fold(id, id);
        // assert
        verifyNever(() => localDatasource.read(any()));
        verifyInOrder([
          () => connectionHandler.hasConnection,
          () => remoteDatasource.fetchMoreThanOneOutput(httpParams: httpParams, modelSerializer: LocationModel.fromMap),
        ]);
        expect(extractedResult, isA<List<LocationEntity>>());
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
