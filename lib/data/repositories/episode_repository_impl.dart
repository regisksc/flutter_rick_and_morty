import 'dart:convert';

import '../../core/data/data.dart';
import '../../core/domain/errors/failures/base_failure.dart';
import '../../core/domain/errors/failures/no_connection_failure.dart';
import '../../core/exports/app_dependencies.dart';
import '../../core/resources/constants/storage_keys.dart';
import '../../domain/entities/episode_entity.dart';
import '../../domain/repositories/episode_repository.dart';
import '../models/models.dart';

class EpisodeRepositoryImpl implements EpisodeRepository {
  EpisodeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionHandler,
  });
  final RemoteDatasource remoteDataSource;
  final LocalDatasource localDataSource;
  final ConnectionHandler connectionHandler;

  @override
  Future<Either<Failure, List<EpisodeEntity>>> getAll() async {
    late Either<Failure, List<EpisodeModel>> result;
    if (await connectionHandler.hasConnection) {
      result = await remoteDataSource.fetchMoreThanOneOutput(
        httpParams: HttpRequestParams(httpMethod: HttpMethod.get, endpoint: makeApiUrl('episode')),
        modelSerializer: EpisodeModel.fromMap,
      );
      return result.map((models) => models.toEntityList);
    } else {
      final storedMap = json.decode((await localDataSource.read(StorageKeys.episodeKey)) ?? '[]') as List;
      final entities = storedMap.map((map) => EpisodeModel.fromMap(map as Map<String, dynamic>).toEntity).toList();
      return Right(entities);
    }
  }

  @override
  Future<Either<Failure, List<EpisodeEntity>>> getSome({required List<int> ids}) async {
    if (await connectionHandler.hasConnection) {
      final result = await remoteDataSource.fetchMoreThanOneOutput(
        httpParams: HttpRequestParams(httpMethod: HttpMethod.get, endpoint: makeApiUrl('episode/$ids')),
        modelSerializer: EpisodeModel.fromMap,
      );
      return result.map((models) => models.map((model) => model.toEntity as EpisodeEntity).toList());
    }
    return const Left(NoConnectionFailure());
  }
}
