import '../../core/data/models/base_model.dart';
import '../../core/domain/domain.dart';
import '../../data/models/models.dart';
import 'entities.dart';

class LocationEntity extends Entity {
  LocationEntity({
    required this.id,
    required this.residentsIds,
    required this.name,
    required this.type,
    required this.dimension,
    this.residents,
  });

  final int id;
  final List<int> residentsIds;
  final String name;
  final String type;
  final String dimension;
  List<CharacterEntity>? residents;

  @override
  List<Object?> get props => [id];

  @override
  Model get toModel => LocationModel(
        id: id,
        residentsIds: residentsIds,
        name: name,
        type: type,
        dimension: dimension,
      );
}
