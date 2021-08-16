import '../../core/data/models/base_model.dart';
import '../../core/domain/domain.dart';
import '../../data/models/episode_model.dart';
import 'entities.dart';

class EpisodeEntity extends Entity {
  EpisodeEntity({
    required this.id,
    required this.characterIds,
    required this.name,
    required this.airDate,
    required this.episode,
    this.characters,
  });

  final int id;
  final List<int> characterIds;
  final String name;
  final String airDate;
  final String episode;
  List<CharacterEntity>? characters;

  @override
  List<Object?> get props => [id];

  @override
  Model get toModel => EpisodeModel(
        id: id,
        characterIds: characterIds,
        name: name,
        airDate: airDate,
        episode: episode,
      );
}
