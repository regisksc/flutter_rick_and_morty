import '../../core/data/models/base_model.dart';
import '../../core/domain/domain.dart';
import 'entities.dart';

class Location extends Entity {
  Location({
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
  List<Character>? residents;

  @override
  List<Object?> get props => [id];

  @override
  // TODO: implement toModel
  Model get toModel => throw UnimplementedError();
}
