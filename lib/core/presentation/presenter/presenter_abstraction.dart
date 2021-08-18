import '../../domain/domain.dart';
import '../states/ui_states.dart';

abstract class Presenter {
  List<Entity> get entities;
  int get currentPage;
  Stream<UiStates> get pageState;
  Future onInit();
}
