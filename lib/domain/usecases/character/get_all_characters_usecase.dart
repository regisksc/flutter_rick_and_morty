import '../../../core/domain/domain.dart';
import '../../../core/exports/app_dependencies.dart';
import '../../domain.dart';

class GetAllCharactersUsecase implements Usecase<List<Character>, NoParams> {
  GetAllCharactersUsecase(this.repository);
  final CharacterRepository repository;

  @override
  Future<Either<Failure, List<Character>>> call(NoParams params) async {
    final result = await repository.getAll<Character>();
    return result;
  }
}