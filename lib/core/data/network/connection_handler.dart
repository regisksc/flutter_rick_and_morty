// Project imports:
import '../../exports/exports.dart';

class ConnectionHandler {
  ConnectionHandler(DataConnectionChecker dataConnectionChecker) : _dataConnectionChecker = dataConnectionChecker;
  final DataConnectionChecker _dataConnectionChecker;

  Future<bool> get hasConnection async => _dataConnectionChecker.hasConnection;
}
