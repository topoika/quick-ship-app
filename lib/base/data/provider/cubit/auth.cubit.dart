part of "../export.provider.dart";

// password visibility cubit
class PasswordCubit extends Cubit<bool> {
  PasswordCubit() : super(true);

  void toggleVisibility() => emit(!state);
}
