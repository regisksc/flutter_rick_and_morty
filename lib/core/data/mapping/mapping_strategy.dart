// Project imports:
import '../models/models.dart';

abstract class MappingStrategy {
  dynamic call<Output extends Model>(dynamic dataFromRemote);
}
