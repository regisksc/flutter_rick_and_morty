import '../http.dart';

bool isSuccessCode(int? code) => code != null && code >= httpOk && code <= httpNoContent;
