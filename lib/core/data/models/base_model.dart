import '../../domain/domain.dart';
import '../../exports/app_dependencies.dart';

abstract class BaseModel extends Equatable {
  Map<String, dynamic> get toMap;
  BaseEntity get toEntity;
}
