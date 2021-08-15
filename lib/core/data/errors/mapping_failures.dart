import '../../domain/errors/failures/failures.dart';

class InvalidMapFailure extends BaseFailure {
  InvalidMapFailure(Type type) : super(title: 'Invalid subtype', message: type.toString());
}
