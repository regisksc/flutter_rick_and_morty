import '../../core/data/models/models.dart';
import '../../core/exports/app_dependencies.dart';
import '../../core/resources/extensions/extensions.dart';
import '../../domain/entities/entities.dart';

class CharacterModel extends Model {
  CharacterModel({
    required this.featuredEpisodeIds,
    required this.lastLocationId,
    required this.originaryLocationId,
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
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

  @override
  List<Object?> get props => [id];

  static CharacterModel fromMap(Map<String, dynamic> map) {
    dynamic results = map;
    if (map.containsKey('results')) results = map['results'];
    return CharacterModel(
      lastLocationId: int.parse(results['location']['url'].toString().allAfter('location/')),
      originaryLocationId: int.parse(results['origin']['url'].toString().allAfter('location/')),
      featuredEpisodeIds: (results['episode'] as List)
          .stringifyMembers
          .map((episode) => int.parse(episode.allAfter('episode/')))
          .toList(),
      id: int.parse(results['id'].toString()),
      name: results['name'].toString(),
      status: results['status'].toString(),
      species: results['species'].toString(),
      type: results['type'].toString(),
      gender: results['gender'].toString(),
      image: results['image'].toString(),
    );
  }

  @override
  CharacterEntity get toEntity => CharacterEntity(
        lastLocationId: lastLocationId,
        originaryLocationId: originaryLocationId,
        featuredEpisodeIds: featuredEpisodeIds,
        id: id,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
        image: image,
      );

  @override
  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'origin': {
          'name': null,
          'url': 'location/$originaryLocationId',
        },
        'location': {
          'name': null,
          'url': 'location/$lastLocationId',
        },
        'image': image,
        'episode': featuredEpisodeIds.map((episodeId) => 'episode/$episodeId'),
      };
}

extension CharacterModelToEntityList on List<CharacterModel> {
  List<CharacterEntity> get toEntityList {
    final entities = <CharacterEntity>[];
    forEach((model) => entities.add(model.toEntity));
    return entities;
  }
}