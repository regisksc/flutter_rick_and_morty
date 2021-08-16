// Project imports:
import '../../domain/domain.dart';
import '../../exports/app_dependencies.dart';

abstract class Model extends Equatable {
  Map<String, dynamic> get toMap;
  Entity get toEntity;
}

extension ToEntityList on List<Model> {
  List<Entity> get toEntityList {
    final entities = <Entity>[];
    forEach((model) => entities.add(model.toEntity));
    return entities;
  }
}
