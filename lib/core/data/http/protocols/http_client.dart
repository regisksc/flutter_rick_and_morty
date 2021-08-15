// Project imports:
import '../../../exports/exports.dart';
import '../../data.dart';

abstract class HttpClient {
  Future<Either<HttpFailure, HttpResponse>> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });
}
