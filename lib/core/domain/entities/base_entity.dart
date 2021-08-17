// Project imports:
import '../../data/models/base_model.dart';
import '../../exports/app_dependencies.dart';

abstract class Entity extends Equatable {
  Model get toModel;
  @override
  bool? get stringify => true;
}
