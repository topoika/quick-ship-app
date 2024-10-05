part of "../export.provider.dart";

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthRepo repo = AuthRepo();
  AuthBloc() : super(AuthInitial()) {
    on<GetAuthUser>(getAuthUser);
    on<AuthLogin>(loginUser);
    on<AuthRegister>(registerUser);
    on<RequestEmailOtp>(requestEmailOtp);
    on<VerifyEmailOtp>(verifyEmailOtp);
    on<DeleteUserAccount>(deleteUser);

    // password reset
    on<RequestResetPassword>(requestPasswordReset);
    on<ResetPasswordEvent>(resetPassword);
    // on<GoogleLogin>(googleLogin);

    // log out
    on<Logout>(logout);
  }
  // request email otp
  void requestEmailOtp(event, emit) async {
    try {
      final otp = await repo.requestEmailOtp();
      emit(EmailVerificationSent(otp: otp!));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // verify email otp
  void verifyEmailOtp(event, emit) async {
    emit(AuthLoading());
    try {
      final user = await repo.verifyEmailOtp(otp: event.otp);
      if (user != null) {
        emit(VerificationSuccess(user: user));
      } else {
        emit(AuthError(message: "User not found"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // request password reset
  void requestPasswordReset(event, emit) async {
    emit(AuthLoading());
    try {
      final otp = await repo.requestPassWordReset(email: event.email);
      emit(PasswordOTPRequestLoaded(otp: otp));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // password reset
  void resetPassword(event, emit) async {
    emit(AuthLoading());
    try {
      await repo.resetPassword(otp: event.otp, password: event.password);
      emit(PasswordResetSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // google login
  // void googleLogin(event, emit) async {
  //   emit(GoogleLogginIn());
  //   try {
  //     final user = await repo.socialLogin(type: "google");
  //     if (user != null) {
  //       emit(LoginSuccess(user: user));
  //     } else {
  //       emit(AuthError(message: "User not found"));
  //     }
  //   } catch (e) {
  //     emit(AuthError(message: e.toString()));
  //   }
  // }

  // get current user
  void getAuthUser(event, emit) async {
    emit(AuthLoading());
    try {
      if (Storage.getData("authToken") == null) {
        throw Exception("User not found");
      }
      final user = await repo.getUser();
      if (user != null) {
        emit(AuthLoaded(user: user));
      } else {
        emit(AuthError(message: "User not found"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // login
  void loginUser(event, emit) async {
    emit(AuthLoading());
    try {
      final user = await repo.loginUser(user: event.user);
      if (user != null) {
        emit(LoginSuccess(user: user));
      } else {
        emit(AuthError(message: "User not found"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // deleteUser
  void deleteUser(event, emit) async {
    emit(AuthLoading());
    try {
      await repo.deleteUser();
      emit(DeleteAccountSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // registerUser
  void registerUser(event, emit) async {
    emit(AuthLoading());
    try {
      final otp = await repo.registerUser(user: event.user);
      emit(EmailVerificationSent(otp: otp!));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void logout(event, emit) async {
    emit(AuthLoading());
    try {
      await repo.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
