part of "../export.provider.dart";

class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class GoogleLogginIn extends AuthState {}

class AuthLoaded extends AuthState {
  final User user;

  AuthLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginSuccess extends AuthState {
  final User user;

  LoginSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterSuccess extends AuthState {
  final String otp;

  RegisterSuccess({required this.otp});

  @override
  List<Object> get props => [otp];
}

class DeleteAccountSuccess extends AuthState {}

class LogoutSuccess extends AuthState {}

class PasswordResetSuccess extends AuthState {}

class PasswordOTPRequestLoaded extends AuthState {
  final String otp;

  PasswordOTPRequestLoaded({required this.otp});

  @override
  List<Object> get props => [otp];
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

class EmailVerificationSent extends AuthState {
  final String otp;
  EmailVerificationSent({required this.otp});

  @override
  List<Object> get props => [otp];
}

class VerificationSuccess extends AuthState {
  final User user;
  VerificationSuccess({required this.user});

  @override
  List<Object> get props => [user];
}
