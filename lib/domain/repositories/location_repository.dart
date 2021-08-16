import '../../core/domain/domain.dart';
import '../../core/exports/app_dependencies.dart';
import '../domain.dart';
import 'base_repository.dart';

abstract class LocationRepository implements BaseRepository {
  @override
  Future<Either<Failure, List<LocationEntity>>> getAll({int? page = 1});
  @override
  Future<Either<Failure, List<LocationEntity>>> getSome({required List<int> ids});
}
