import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import '../states/ui_states.dart';

abstract class Presenter {
  List<Entity> get entities;
  int get currentPage;
  ValueNotifier<UiStates> get pageState;
  Future onInit();
}
