// Package imports:

// Project imports:
import '../../../exports/app_dependencies.dart';

class LocalDatasource {
  LocalDatasource(GetStorage storage) : _storage = storage;
  final GetStorage _storage;

  // @override
  // Future<void> saveValue({required String key, required String value}) async {
  //   await _storage.(key, value);
  // }

  // @override
  // Future<void> deleteValue(String key) async {
  //   await _storage.remove(key);
  // }

  // @override
  // Future<String> getValue(String key) async {
  //   return Future.value(_storage.getString(key));
  // }
}
