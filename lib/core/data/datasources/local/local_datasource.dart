import '../../../exports/app_dependencies.dart';
import '../../storage/storage.dart';

class LocalDatasource implements StorageSave, StorageRead {
  LocalDatasource(GetStorage storage) : _storage = storage;
  final GetStorage _storage;

  @override
  Future<void> save({required String key, required String value}) async {
    await _storage.write(key, value);
  }

  @override
  Future<String?> read(String key) async {
    if (_storage.hasData(key)) return _storage.read(key);
  }
}
