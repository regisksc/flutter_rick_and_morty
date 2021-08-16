import 'base_repository.dart';

abstract class LocationRepository implements BaseRepository {
  Future<List<Location>> getAll<Location>();
  Future<List<Location>> getSome<Location>();
}
