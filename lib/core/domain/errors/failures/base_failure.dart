import '../../../exports/app_dependencies.dart';

abstract class Failure extends Equatable with Exception {
  const Failure({this.title = 'Error', this.message});

  final String? title;
  final String? message;

  @override
  List<Object?> get props => [title, message];
}
