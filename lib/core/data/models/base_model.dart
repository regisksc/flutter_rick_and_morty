// Project imports:
import '../../domain/domain.dart';
import '../../exports/app_dependencies.dart';

abstract class Model extends Equatable {
  Map<String, dynamic> get toMap;
  Entity get toEntity;
}
