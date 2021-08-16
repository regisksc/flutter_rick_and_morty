import '../../../core/domain/domain.dart';
import '../../../core/exports/app_dependencies.dart';
import '../../domain.dart';

class GetAllCharactersUsecase implements Usecase<List<CharacterEntity>, int> {
  GetAllCharactersUsecase(this.repository);
  final CharacterRepository repository;

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(int page) async {
    final result = await repository.getAll(page: page);
    return result;
  }
}
