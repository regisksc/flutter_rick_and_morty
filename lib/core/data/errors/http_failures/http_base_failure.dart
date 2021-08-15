import '../../../domain/errors/error.dart';

abstract class HttpFailure extends Failure {
  const HttpFailure(
    this.code, {
    String? message,
    String? title,
  }) : super(message: message, title: title);

  final int? code;
}
