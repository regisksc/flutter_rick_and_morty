import '../../core/domain/domain.dart';
import '../../core/exports/app_dependencies.dart';

abstract class BaseRepository {
  Future<Either<Failure, List<T>>> getAll<T>();
  Future<Either<Failure, List<T>>> getSome<T>();
}
