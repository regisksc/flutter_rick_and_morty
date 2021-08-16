import '../../../core/domain/domain.dart';
import '../../../core/exports/app_dependencies.dart';
import '../../domain.dart';

class GetAllEpisodesUsecase implements Usecase<List<Episode>, NoParams> {
  GetAllEpisodesUsecase(this.repository);
  final EpisodeRepository repository;

  @override
  Future<Either<Failure, List<Episode>>> call(NoParams params) async {
    final result = await repository.getAll<Episode>();
    return result;
  }
}
