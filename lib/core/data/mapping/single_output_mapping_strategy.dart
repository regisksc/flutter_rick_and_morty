// Project imports:
import '../../domain/domain.dart';
import '../../exports/app_dependencies.dart';
import '../data.dart';
import '../errors/mapping/mapping.dart';
import '../models/base_model.dart';
import 'mapping_strategy.dart';

class SingleOutputMappingStrategy implements MappingStrategy {
  SingleOutputMappingStrategy(this.modelSerializer);

  final ModelSerializer modelSerializer;

  @override
  Either<Failure, Output> call<Output extends BaseModel>(dynamic dataFromRemote) {
    if (dataFromRemote is Map<String, dynamic>) {
      return Right(modelSerializer(dataFromRemote) as Output);
    }
    return Left(InvalidMapFailure(dataFromRemote.runtimeType));
  }
}
