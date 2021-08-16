import '../../../core/domain/domain.dart';
import '../../../core/exports/app_dependencies.dart';
import '../../domain.dart';

class GetAllLocationsUsecase implements Usecase<List<Location>, NoParams> {
  GetAllLocationsUsecase(this.repository);
  final LocationRepository repository;

  @override
  Future<Either<Failure, List<Location>>> call(NoParams params) async {
    final result = await repository.getAll<Location>();
    return result;
  }
}
