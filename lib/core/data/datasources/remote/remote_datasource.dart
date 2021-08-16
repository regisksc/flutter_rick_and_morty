import '../../../domain/errors/error.dart';
import '../../../exports/app_dependencies.dart';
import '../../data.dart';

abstract class RemoteDatasource {
  Future<Either<Failure, Output>> fetchOneOutput<Output extends BaseModel>({
    required HttpRequestParams httpParams,
    required ModelSerializer modelSerializer,
  });
  Future<Either<Failure, List<Output>>> fetchMoreThanOneOutput<Output extends BaseModel>({
    required HttpRequestParams httpParams,
    required ModelSerializer modelSerializer,
  });
}
