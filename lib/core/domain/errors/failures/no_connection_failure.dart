// Project imports:
import 'failures.dart';

class NoConnectionFailure extends Failure {
  const NoConnectionFailure()
      : super(
          title: 'Connection Failure',
          message: "It seems you don't have connection right now",
        );
}
