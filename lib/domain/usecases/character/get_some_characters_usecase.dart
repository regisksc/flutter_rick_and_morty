import '../../../core/domain/domain.dart';
import '../../../core/exports/app_dependencies.dart';
import '../../domain.dart';
import '../../repositories/repositories.dart';

class GetSomeCharactersUsecase implements Usecase<List<CharacterEntity>, List<int>> {
  GetSomeCharactersUsecase(this.repository);
  final CharacterRepository repository;

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(List<int> params) async {
    final result = await repository.getSome<CharacterEntity>();
    return result;
  }
}
