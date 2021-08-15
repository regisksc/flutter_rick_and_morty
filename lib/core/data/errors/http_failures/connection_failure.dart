// Project imports:
import '../../../resources/constants/error_strings.dart';
import '../errors.dart';

class ConnectionFailure extends HttpFailure {
  const ConnectionFailure({String? message, int? code})
      : super(
          code,
          message: message ?? ErrorStrings.noConnection,
          title: 'Connectivity issue.',
        );
}
