// Project imports:
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
  Either<InvalidMapFailure, List<Output>> call<Output extends Model>(dynamic dataFromRemote) {
    _mapOrListOfMap = dataFromRemote;
    try {
      dataFromRemote as Iterable;
      final mappedIterable = _list.map((json) => modelSerializer(json as Map<String, dynamic>) as Output);
      return Right(mappedIterable.toList());
    } catch (e) {
      print(e);
      return Left(_failure());
    }
  }

  InvalidMapFailure _failure() => InvalidMapFailure(_mapOrListOfMap.runtimeType);
}
