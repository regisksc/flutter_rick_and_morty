import '../../../core/domain/domain.dart';
import '../../../core/exports/app_dependencies.dart';
import '../../domain.dart';
import '../../repositories/repositories.dart';

class GetSomeEpisodesUsecase implements Usecase<List<Episode>, List<int>> {
  GetSomeEpisodesUsecase(this.repository);
  final EpisodeRepository repository;

  @override
  Future<Either<Failure, List<Episode>>> call(List<int> params) async {
    final result = await repository.getSome<Episode>();
    return result;
  }
}
