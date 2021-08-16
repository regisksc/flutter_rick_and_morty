import '../../../core/domain/domain.dart';
import '../../../core/exports/app_dependencies.dart';
import '../../domain.dart';

class GetOneLocationUsecase implements Usecase<List<LocationEntity>, int> {
  GetOneLocationUsecase(this.repository);
  final LocationRepository repository;

  @override
  Future<Either<Failure, List<LocationEntity>>> call(int id) async {
    final result = await repository.getSome(ids: [id]);
    return result;
  }
}
