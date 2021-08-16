import '../../core/data/models/base_model.dart';
import '../../core/domain/domain.dart';
import 'entities.dart';

class Character extends Entity {
  Character({
    required this.lastLocationId,
    required this.originaryLocationId,
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.episode,
    this.origin,
    this.location,
  });

  final int id;
  final int lastLocationId;
  final int originaryLocationId;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final List<String> episode;
  Location? origin;
  Location? location;

  @override
  List<Object?> get props => [id];

  @override
  // TODO: implement toModel
  Model get toModel => throw UnimplementedError();
}
