import '../../exports/app_dependencies.dart';
import '../data.dart';
import '../errors/mapping/mapping.dart';
import 'mapping_strategy.dart';

class MultipleOutputMappingStrategy implements MappingStrategy {
  MultipleOutputMappingStrategy(this.modelSerializer);

  final ModelSerializer modelSerializer;

  late dynamic _mapOrListOfMap;
  List get _list => _mapOrListOfMap as List;

  @override
  Either<InvalidMapFailure, List<Output>> call<Output extends BaseModel>(dynamic dataFromRemote) {
    _mapOrListOfMap = dataFromRemote;
    if (dataFromRemote is! List) throw _failure();
    try {
      final mappedIterable = _list.map((json) => modelSerializer(json as Map<String, dynamic>) as Output);
      return Right(mappedIterable.toList());
    } catch (e) {
      return Left(_failure());
    }
  }

  InvalidMapFailure _failure() => InvalidMapFailure(_mapOrListOfMap.runtimeType);
}
