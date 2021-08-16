import '../../core/domain/domain.dart';
import '../../core/exports/app_dependencies.dart';
import 'base_repository.dart';

abstract class EpisodeRepository implements BaseRepository {
  @override
  Future<Either<Failure, List<Episode>>> getAll<Episode>();
  @override
  Future<Either<Failure, List<Episode>>> getSome<Episode>();
}
