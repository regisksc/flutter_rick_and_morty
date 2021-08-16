import 'base_repository.dart';

abstract class EpisodeRepository implements BaseRepository {
  Future<List<Episode>> getAll<Episode>();
  Future<List<Episode>> getSome<Episode>();
}
