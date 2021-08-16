import '../../core/data/models/base_model.dart';
import '../../core/domain/domain.dart';
import 'entities.dart';

class Episode extends Entity {
  Episode({
    required this.id,
    required this.characterIds,
    required this.name,
    required this.airDate,
    required this.episode,
    this.characters,
  });

  final int id;
  final int characterIds;
  final String name;
  final String airDate;
  final String episode;
  List<Character>? characters;

  @override
  List<Object?> get props => [id];

  @override
  // TODO: implement toModel
  Model get toModel => throw UnimplementedError();
}
