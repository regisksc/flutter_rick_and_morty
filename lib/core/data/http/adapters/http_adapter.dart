import '../../../exports/app_dependencies.dart';
import '../../data.dart';
import '../http.dart';

class HttpAdapter implements HttpClient {
  HttpAdapter(Dio client) : _client = client;
  final Dio _client;

  @override
  Future<Either<HttpFailure, HttpResponse>> request({
    required String method,
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final options = _getRequestOptions(headers);

    try {
      final response = await _fetchResponse(
        method: method,
        url: url,
        body: body,
        queryParameters: queryParameters,
        options: options,
      );
      if (isSuccess(response?.statusCode) == false) return Left(UnexpectedFailure(message: response?.statusMessage));
      return Right(_handleSuccess(response!));
    } on DioError catch (err) {
      return Left(UnexpectedFailure(code: err.response?.statusCode, message: err.message));
    }
  }

  Options _getRequestOptions(Map<String, String>? headers) {
    final defaultHeaders = {contentType: applicationJson, accept: applicationJson};
    return Options(headers: defaultHeaders..addAll(headers ?? {}));
  }

  Future<Response?> _fetchResponse({
    required String method,
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    switch (method) {
      case httpGet:
        return _client.get(url, queryParameters: queryParameters, options: options);
      case httpPost:
        return _client.post(url, data: body, options: options);
      case httpDelete:
        return _client.delete(url, queryParameters: queryParameters, options: options, data: body);
      case httpPut:
        return _client.put(url, queryParameters: queryParameters, options: options, data: body);
      case httpPatch:
        return _client.patch(url, queryParameters: queryParameters, options: options, data: body);
    }
  }

  HttpResponse _handleSuccess(Response response) {
    final responseData = (response.data ?? <String, dynamic>{}) as Map<String, dynamic>;
    final message = responseData.containsKey('message') ? response.data['message'].toString() : '';
    return HttpResponse(
      code: response.statusCode!,
      data: responseData,
      message: message,
    );
  }
}
