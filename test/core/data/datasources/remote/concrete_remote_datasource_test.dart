// Project imports:
import 'package:flutter_rick_morty/core/data/data.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';
import '../../../../test_utils/constants/data_type_test_constants.dart';
import '../../../../test_utils/mocks/test_mocks.dart';

void main() {
  late RemoteDatasource sut;
  late HttpClientMock http;
  late String url;
  late HttpMethod method;
  late Map<String, dynamic> body;
  late Map<String, dynamic> query;
  late Map<String, String> headers;
  late ModelMock model;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    http = HttpClientMock();
    sut = ConcreteRemoteDatasource(client: http);

    url = faker.internet.httpsUrl();
    method = HttpMethod.get;
    body = anyMap;
    query = anyMap;
    headers = {'key': 'string_header'};

    model = ModelMock();
  });

  When mockHttpRequest({String? url, String? body, String? query}) {
    return when(
      () => http.request(
        url: any(named: 'url'),
        method: any(named: 'method'),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
        queryParameters: any(named: 'queryParameters'),
      ),
    );
  }

  group('When fetching one -', () {
    test(
      'should return a single Output ',
      () async {
        // arrange
        final httpResponse = HttpResponse(code: 200, data: anyMap);
        mockHttpRequest().thenAnswer((_) async => Right<HttpFailure, HttpResponse>(httpResponse));
        final httpParams = HttpRequestParams(
          httpMethod: method,
          endpoint: url,
          queryParameters: query,
          body: body,
          headers: headers,
        );

        // act
        final result = await sut.fetchOneOutput<ModelMock>(
          httpParams: httpParams,
          modelSerializer: model.fromMap,
        );
        final extractedResult = result.fold(id, id);

        // assert
        expect(extractedResult, isA<ModelMock>());
      },
    );
  });
  group('When fetching many -', () {
    test(
      'should return a List of Output ',
      () async {
        // arrange
        final httpResponse = HttpResponse(code: 200, data: [anyMap, anyMap]);
        mockHttpRequest().thenAnswer((_) async => Right<HttpFailure, HttpResponse>(httpResponse));
        final httpParams = HttpRequestParams(
          httpMethod: method,
          endpoint: url,
          queryParameters: query,
          body: body,
          headers: headers,
        );

        // act
        final result = await sut.fetchMoreThanOneOutput<ModelMock>(
          httpParams: httpParams,
          modelSerializer: model.fromMap,
        );
        final extractedResult = result.fold(id, id);

        // assert
        expect(extractedResult, isA<List<ModelMock>>());
      },
    );
  });
}
