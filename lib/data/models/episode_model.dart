import "../../core/data/models/models.dart";
import "../../core/exports/app_dependencies.dart";
import "../../core/resources/extensions/extensions.dart";
import "../../domain/entities/entities.dart";

class EpisodeModel extends Model {
  EpisodeModel({
    required this.id,
    required this.characterIds,
    required this.name,
    required this.airDate,
    required this.episode,
  });

  final int id;
  final List<int> characterIds;
  final String name;
  final String airDate;
  final String episode;

  @override
  List<Object?> get props => [id];

  static EpisodeModel fromMap(Map<String, dynamic> map) {
    dynamic results = map;
    if (map.containsKey('results')) results = map['results'];
    return EpisodeModel(
      id: int.tryParse(results["id"].toString()) ?? -1,
      characterIds: (results["characters"] as List)
          .stringifyMembers
          .map((character) => int.tryParse(character.allAfter("character/")) ?? -1)
          .toList(),
      name: results["name"].toString(),
      airDate: results["airDate"].toString(),
      episode: results["episode"].toString(),
    );
  }

  @override
  EpisodeEntity get toEntity => EpisodeEntity(
        id: id,
        characterIds: characterIds,
        name: name,
        airDate: airDate,
        episode: episode,
      );

  @override
  Map<String, dynamic> get toJson => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "characters": characterIds.map((characterId) => "character/$characterId"),
      };
}

extension EpisodeModelToEntityList on List<EpisodeModel> {
  List<EpisodeEntity> get toEntityList {
    final entities = <EpisodeEntity>[];
    forEach((model) => entities.add(model.toEntity));
    return entities;
  }
}
