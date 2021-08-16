import 'package:flutter_rick_morty/core/data/data.dart';
import 'package:flutter_rick_morty/core/exports/exports.dart';

class ModelMock extends Mock with EquatableMixin implements BaseModel {
  dynamic field;

  ModelMock fromMap(Map<String, dynamic> json) {
    field = json['field'];
    return this;
  }

  @override
  List<Object?> get props => [field];
}

class NetworkInfoMock extends Mock implements ConnectionHandler {}

class HttpClientMock extends Mock implements HttpClient {}

class SingleOutputMappingStrategyMock extends Mock implements SingleOutputMappingStrategy {}

class MultipleOutputMappingStrategyMock extends Mock implements SingleOutputMappingStrategy {}

// datasources
class ConcreteRemoteDatasourceMock extends Mock implements ConcreteRemoteDatasource {}
