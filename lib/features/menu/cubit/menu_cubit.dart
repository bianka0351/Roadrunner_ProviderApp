// menu_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial(isOpen: false));

  void toggleMenu() {
    final currentState = state as MenuInitial;
    emit(MenuInitial(isOpen: !currentState.isOpen));
  }
}