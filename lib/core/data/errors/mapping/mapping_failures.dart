// Project imports:
import '../../../domain/domain.dart';

class InvalidMapFailure extends Failure {
  InvalidMapFailure(Type type) : super(title: 'Invalid subtype', message: type.toString());
}
