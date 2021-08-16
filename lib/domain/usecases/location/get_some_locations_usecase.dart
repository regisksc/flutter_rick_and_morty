import '../../../core/domain/domain.dart';
import '../../../core/exports/app_dependencies.dart';
import '../../domain.dart';
import '../../repositories/repositories.dart';

class GetSomeLocationsUsecase implements Usecase<List<Location>, List<int>> {
  GetSomeLocationsUsecase(this.repository);
  final LocationRepository repository;

  @override
  Future<Either<Failure, List<Location>>> call(List<int> params) async {
    final result = await repository.getSome<Location>();
    return result;
  }
}
