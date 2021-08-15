import 'failures.dart';

class UnrecognizedFailure extends Failure {
  const UnrecognizedFailure()
      : super(
          title: 'Unrecognized Error',
          message: 'Oops, something happenned. Try again in a few minutes',
        );
}
