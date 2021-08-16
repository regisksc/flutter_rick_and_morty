import '../../core/domain/domain.dart';
import '../../core/exports/app_dependencies.dart';
import '../domain.dart';
import 'base_repository.dart';

abstract class EpisodeRepository implements BaseRepository {
  @override
  Future<Either<Failure, List<EpisodeEntity>>> getAll({int? page = 1});
  @override
  Future<Either<Failure, List<EpisodeEntity>>> getSome({required List<int> ids});
}
