import '../../../core/domain/domain.dart';
import '../../../core/exports/app_dependencies.dart';
import '../../domain.dart';

class GetAllLocationsUsecase implements Usecase<List<LocationEntity>, NoParams> {
  GetAllLocationsUsecase(this.repository);
  final LocationRepository repository;

  @override
  Future<Either<Failure, List<LocationEntity>>> call(NoParams params) async {
    final result = await repository.getAll();
    return result;
  }
}
