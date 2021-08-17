// Project imports:
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
      return isSuccess(response?.statusCode)
          ? Right(_handleSuccess(response!))
          : Left(_unexpectedFailure(response?.statusCode, response?.statusMessage));
    } on DioError catch (err) {
      return Left(_unexpectedFailure(err.response?.statusCode, err.message));
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
    if (method.toLowerCase() == 'get') {
      return _client.get(url, queryParameters: queryParameters, options: options);
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

  UnexpectedFailure _unexpectedFailure(int? code, String? message) => UnexpectedFailure(code: code, message: message);
}
