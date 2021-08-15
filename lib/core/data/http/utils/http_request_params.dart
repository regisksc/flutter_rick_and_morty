// Project imports:
import '../../../exports/app_dependencies.dart';
import '../../data.dart';

enum HttpMethod { get, post, put, delete, patch }

class HttpRequestParams extends Equatable {
  const HttpRequestParams({
    required HttpMethod httpMethod,
    required this.endpoint,
    this.queryParameters,
    this.body,
    this.headers,
  }) : _httpMethod = httpMethod;

  final HttpMethod _httpMethod;
  final String endpoint;
  final Map<String, String>? headers;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? body;

  String get method {
    switch (_httpMethod) {
      case HttpMethod.get:
        return httpGet;
      case HttpMethod.post:
        return httpPost;
      case HttpMethod.put:
        return httpPut;
      case HttpMethod.delete:
        return httpDelete;
      case HttpMethod.patch:
        return httpPatch;
    }
  }

  @override
  List<Object?> get props => [
        _httpMethod,
        endpoint,
        body,
        headers,
        queryParameters,
      ];
}
