import '../../../core/domain/domain.dart';
import '../../../core/exports/app_dependencies.dart';
import '../../domain.dart';

class GetAllEpisodesUsecase implements Usecase<List<EpisodeEntity>, NoParams> {
  GetAllEpisodesUsecase(this.repository);
  final EpisodeRepository repository;

  @override
  Future<Either<Failure, List<EpisodeEntity>>> call(NoParams params) async {
    final result = await repository.getAll<EpisodeEntity>();
    return result;
  }
}
