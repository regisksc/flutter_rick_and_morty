class HttpResponse {
  HttpResponse({
    required this.code,
    this.message,
    this.data,
  });

  final int code;
  final dynamic data; // Should be Either a List<Json> or a Json
  final String? message;

  @override
  String toString() => "'code': $code, 'message': $message, 'data': ${data.toString()}";
}
