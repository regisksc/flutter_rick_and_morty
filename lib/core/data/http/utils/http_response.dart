class HttpResponse {
  HttpResponse({
    required this.code,
    this.data,
  });

  final int code;
  final dynamic data; // Should be Either a List<Json> or a Json

  @override
  String toString() => "'code': $code, 'data': ${data.toString()}";
}
