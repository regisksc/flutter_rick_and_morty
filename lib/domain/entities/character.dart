import '../../core/data/models/base_model.dart';
import '../../core/domain/domain.dart';
import '../../data/models/models.dart';
import 'entities.dart';

class Character extends Entity {
  Character({
    required this.lastLocationId,
    required this.originaryLocationId,
    required this.featuredEpisodeIds,
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    this.episodes,
    this.origin,
    this.location,
  });

  final int id;
  final int lastLocationId;
  final int originaryLocationId;
  final List<int> featuredEpisodeIds;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  List<Episode>? episodes;
  Location? origin;
  Location? location;

  @override
  List<Object?> get props => [id];

  @override
  Model get toModel => CharacterModel(
        featuredEpisodeIds: featuredEpisodeIds,
        lastLocationId: lastLocationId,
        originaryLocationId: originaryLocationId,
        id: id,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
        image: image,
      );
}
