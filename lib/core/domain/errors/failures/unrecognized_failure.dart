import 'failures.dart';

class UnrecognizedFailure extends BaseFailure {
  const UnrecognizedFailure()
      : super(
          title: 'Erro desconhecido',
          message: 'Ops, algo deu errado. Tente novamente daqui uns minutos',
        );
}
