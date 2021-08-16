import '../../core/domain/domain.dart';
import '../../core/exports/app_dependencies.dart';
import '../domain.dart';
import 'base_repository.dart';

abstract class CharacterRepository implements BaseRepository {
  @override
  Future<Either<Failure, List<CharacterEntity>>> getAll({int? page = 1});
  @override
  Future<Either<Failure, List<CharacterEntity>>> getSome({required List<int> ids});
}
