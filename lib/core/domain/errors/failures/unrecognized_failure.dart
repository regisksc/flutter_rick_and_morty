import 'failures.dart';

class UnrecognizedFailure extends BaseFailure {
  const UnrecognizedFailure()
      : super(
          title: 'Unrecognized Error',
          message: 'Oops, something happenned. Try again in a few minutes',
        );
}
