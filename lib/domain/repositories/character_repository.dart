import 'base_repository.dart';

abstract class CharacterRepository implements BaseRepository {
  Future<List<Character>> getAll<Character>();
  Future<List<Character>> getSome<Character>();
}
