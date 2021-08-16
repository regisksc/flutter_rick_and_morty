abstract class BaseRepository {
  Future<List<T>> getAll<T>();
  Future<List<T>> getSome<T>();
}
