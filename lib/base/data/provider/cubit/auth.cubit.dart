part of "../export.provider.dart";

// password visibility cubit
class PasswordCubit extends Cubit<bool> {
  PasswordCubit() : super(true);

  void toggleVisibility() => emit(!state);
}

// navigator cubit for navigation
class NavigatorCubit extends Cubit<int> {
  NavigatorCubit() : super(0);

  void setIndex(int index) => emit(index);

  int get index => state;
}
