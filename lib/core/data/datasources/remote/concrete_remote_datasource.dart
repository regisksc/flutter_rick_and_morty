// Project imports:
import '../../../domain/domain.dart';
import '../../../exports/app_dependencies.dart';
import '../../data.dart';
import '../../mapping/mapping.dart';
import 'remote_datasource.dart';

class ConcreteRemoteDatasource implements RemoteDatasource {
  ConcreteRemoteDatasource({
    required this.client,
  });
  final HttpClient client;

  Future<Either<HttpFailure, HttpResponse>> _getRawDataFromRemote(HttpRequestParams httpParams) async {
    final response = await client.request(
      url: httpParams.endpoint,
      method: httpParams.method,
      body: httpParams.body,
      headers: httpParams.headers,
      queryParameters: httpParams.queryParameters,
    );
    return response;
  }

  @override
  Future<Either<Failure, Output>> fetchOneOutput<Output extends BaseModel>({
    required HttpRequestParams httpParams,
    required ModelSerializer modelSerializer,
  }) async {
    final returnedData = await _getRawDataFromRemote(httpParams);
    return returnedData.fold(
      (failure) => Left(failure),
      (result) {
        final mapOne = SingleOutputMappingStrategy(modelSerializer);
        return mapOne<Output>(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, List<Output>>> fetchMoreThanOneOutput<Output extends BaseModel>({
    required HttpRequestParams httpParams,
    required ModelSerializer modelSerializer,
  }) async {
    final returnedData = await _getRawDataFromRemote(httpParams);
    return returnedData.fold(
      (failure) => Left(failure),
      (result) {
        final mapMany = MultipleOutputMappingStrategy(modelSerializer);
        return mapMany<Output>(result.data as Iterable);
      },
    );
  }
}
