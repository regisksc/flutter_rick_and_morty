import '../../core/domain/domain.dart';
import '../../core/exports/app_dependencies.dart';
import 'base_repository.dart';

abstract class CharacterRepository implements BaseRepository {
  @override
  Future<Either<Failure, List<Character>>> getAll<Character>();
  @override
  Future<Either<Failure, List<Character>>> getSome<Character>();
}
