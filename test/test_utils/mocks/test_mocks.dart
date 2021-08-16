// Project imports:
import 'package:flutter_rick_morty/core/data/data.dart';
import 'package:flutter_rick_morty/core/domain/domain.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';

class ModelMock extends Mock with EquatableMixin implements Model {
  dynamic field;

  ModelMock fromMap(Map<String, dynamic> json) {
    field = json['field'];
    return this;
  }

  @override
  List<Object?> get props => [field];
}

class FailureMock extends Mock with EquatableMixin implements Failure {}

class ConnectionHandlerMock extends Mock implements ConnectionHandler {}

class HttpClientMock extends Mock implements HttpClient {}
