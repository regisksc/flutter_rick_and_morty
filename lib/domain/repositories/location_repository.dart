import '../../core/domain/domain.dart';
import '../../core/exports/app_dependencies.dart';
import 'base_repository.dart';

abstract class LocationRepository implements BaseRepository {
  Future<Either<Failure, List<Location>>> getAll<Location>();
  Future<Either<Failure, List<Location>>> getSome<Location>();
}
