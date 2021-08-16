import '../../core/data/data.dart';
import '../../core/domain/domain.dart';
import '../../core/exports/app_dependencies.dart';

abstract class BaseRepository {
  BaseRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionHandler,
  });
  final RemoteDatasource remoteDataSource;
  final LocalDatasource localDataSource;
  final ConnectionHandler connectionHandler;

  Future<Either<Failure, List<Object>>> getAll({int? page = 1});
  Future<Either<Failure, List<Object>>> getSome({required List<int> ids});
}
