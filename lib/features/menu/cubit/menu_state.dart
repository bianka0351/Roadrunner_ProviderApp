// menu_state.dart
abstract class MenuState {}

class MenuInitial extends MenuState {
  final bool isOpen;

  MenuInitial({required this.isOpen});
}