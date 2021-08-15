// Project imports:
import '../../domain/errors/failures/failures.dart';

class InvalidMapFailure extends Failure {
  InvalidMapFailure(Type type) : super(title: 'Invalid subtype', message: type.toString());
}
