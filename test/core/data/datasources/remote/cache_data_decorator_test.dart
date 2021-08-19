import 'dart:convert';

import 'package:flutter_rick_morty/core/data/data.dart';
import 'package:flutter_rick_morty/core/data/datasources/remote/cache_data_decorator.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';

import '../../../../test_utils/constants/data_type_test_constants.dart';
import '../../../../test_utils/mocks/datasource_mocks.dart';
import '../../../../test_utils/mocks/test_mocks.dart';

void main() {
  late String keyToStoreAt;
  late RemoteDatasource decoratee;
  late RemoteDatasource sut;
  late LocalDatasource stash;
  late Model model;
  late List<Model> modelList;
  late HttpRequestParams httpParams;
  late ModelSerializer modelSerializer;

  setUpAll(() {
    httpParams = HttpRequestParams(httpMethod: HttpMethod.get, endpoint: faker.internet.httpsUrl());
    registerFallbackValue(httpParams);
  });

  setUp(() {
    decoratee = RemoteDatasourceMock();
    stash = LocalDatasourceMock();
    keyToStoreAt = faker.lorem.word();
    model = ModelMock();
    modelList = [model, model];
    sut = CacheDataDecorator(
      decoratee: decoratee,
      stash: stash,
      keyToStoreAt: keyToStoreAt,
    );
  });

  test(
    'should store data on decoratee fetchOneOutput method',
    () async {
      // arrange
      when(() => decoratee.fetchOneOutput(
            httpParams: any(named: 'httpParams'),
            modelSerializer: any(named: 'modelSerializer'),
          )).thenAnswer((_) async => Right(model));

      when(() => model.toJson).thenReturn({'field': 'data'});
      when(() => stash.save(key: any(named: 'key'), value: any(named: 'value'))).thenAnswer((_) => Future.value());
      when(() => stash.read(any())).thenAnswer((_) => Future.value(json.encode({'field': 'data'})));

      // act
      await sut.fetchOneOutput(
        httpParams: httpParams,
        modelSerializer: (anyMap) => model,
      );
      final retrievedInfo = await stash.read(keyToStoreAt);

      // assert
      verifyInOrder([
        () => decoratee.fetchOneOutput(
              httpParams: any(named: 'httpParams'),
              modelSerializer: any(named: 'modelSerializer'),
            ),
        () => model.toJson,
        () => stash.save(key: any(named: 'key'), value: any(named: 'value')),
      ]);
      expect(retrievedInfo, equals(json.encode({'field': 'data'})));
    },
  );
}
