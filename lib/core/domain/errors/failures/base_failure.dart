import '../../../exports/app_dependencies.dart';

abstract class BaseFailure extends Equatable with Exception {
  const BaseFailure({this.title = 'Error', this.message});

  final String? title;
  final String? message;

  @override
  List<Object?> get props => [title, message];
}
