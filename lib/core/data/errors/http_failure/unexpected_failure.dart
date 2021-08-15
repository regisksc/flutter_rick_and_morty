import '../../../resources/constants/constants.dart';
import 'http_base_failure.dart';

class UnexpectedFailure extends HttpFailure {
  const UnexpectedFailure({String? message, int? code})
      : super(
          code,
          message: message ?? ErrorStrings.unexpected,
          title: 'Unexpected Error',
        );
}
