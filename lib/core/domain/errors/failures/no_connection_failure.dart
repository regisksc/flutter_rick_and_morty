import 'failures.dart';

class NoConnectionFailure extends BaseFailure {
  const NoConnectionFailure()
      : super(
          title: 'Connection Failure',
          message: "It seems you don't have connection right now",
        );
}
