import '../../core/data/models/models.dart';
import '../../core/exports/app_dependencies.dart';
import '../../core/resources/extensions/extensions.dart';
import '../../domain/entities/entities.dart';

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
    return EpisodeModel(
      id: int.parse(map['id'].toString()),
      characterIds: (map['characters'] as List)
          .stringifyMembers
          .map((character) => int.parse(character.allAfter('character/')))
          .toList(),
      name: map['name'].toString(),
      airDate: map['airDate'].toString(),
      episode: map['episode'].toString(),
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
  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'air_date': airDate,
        'episode': episode,
        'characters': characterIds.map((characterId) => 'character/$characterId'),
      };
}
