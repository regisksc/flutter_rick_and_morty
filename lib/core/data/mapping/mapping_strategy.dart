import '../models/models.dart';

abstract class MappingStrategy {
  dynamic call<Output extends BaseModel>(dynamic dataFromRemote);
}
