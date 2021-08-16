import 'dart:convert';

import '../../core/data/data.dart';
import '../../core/domain/errors/failures/base_failure.dart';
import '../../core/domain/errors/failures/no_connection_failure.dart';
import '../../core/exports/app_dependencies.dart';
import '../../core/resources/constants/storage_keys.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../models/models.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionHandler,
  });
  final RemoteDatasource remoteDataSource;
  final LocalDatasource localDataSource;
  final ConnectionHandler connectionHandler;

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAll({int? page = 1}) async {
    late Either<Failure, List<CharacterModel>> result;
    if (await connectionHandler.hasConnection) {
      final query = {'page': page};
      result = await remoteDataSource.fetchMoreThanOneOutput(
        httpParams: HttpRequestParams(
          httpMethod: HttpMethod.get,
          endpoint: makeApiUrl('character'),
          queryParameters: query,
        ),
        modelSerializer: CharacterModel.fromMap,
      );
      return result.map((models) => models.toEntityList);
    } else {
      final storedMap = json.decode((await localDataSource.read(StorageKeys.episodeKey)) ?? '[]') as List;
      final entities = storedMap.map((map) => CharacterModel.fromMap(map as Map<String, dynamic>).toEntity).toList();
      return Right(entities);
    }
  }

  @override
  Future<Either<Failure, List<CharacterEntity>>> getSome({required List<int> ids}) async {
    if (await connectionHandler.hasConnection) {
      final result = await remoteDataSource.fetchMoreThanOneOutput(
        httpParams: HttpRequestParams(httpMethod: HttpMethod.get, endpoint: makeApiUrl('character/$ids')),
        modelSerializer: CharacterModel.fromMap,
      );
      return result.map((models) => models.map((model) => model.toEntity as CharacterEntity).toList());
    }
    return const Left(NoConnectionFailure());
  }
}
