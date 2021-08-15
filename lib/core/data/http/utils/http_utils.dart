// Project imports:
import '../http.dart';

bool isSuccess(int? code) => code != null && code >= httpOk && code <= httpNoContent;
