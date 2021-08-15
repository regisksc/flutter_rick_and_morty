import '../../data/models/base_model.dart';
import '../../exports/app_dependencies.dart';

abstract class BaseEntity extends Equatable {
  BaseModel get toModel;
}
