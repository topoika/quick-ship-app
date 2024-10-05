// ignore_for_file: public_member_api_docs, sort_constructors_first
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

// otp cubit to store otp code
class OtpCubit extends Cubit<OTPState> {
  OtpCubit() : super(OTPState.initial());

  // set otp
  void setOtp(String otp) => emit(state.copyWith(otp: otp));
  void setType(String type) => emit(state.copyWith(type: type));

  void setOtpState(String otp, String type) =>
      emit(OTPState(otp: otp, type: type));

  void clear() => emit(OTPState.initial());
}

class OTPState {
  String? otp;
  String? type;

  OTPState({this.otp, this.type});
  factory OTPState.initial() {
    return OTPState();
  }

  OTPState copyWith({
    String? otp,
    String? type,
  }) {
    return OTPState(
      otp: otp ?? this.otp,
      type: type ?? this.type,
    );
  }
}
