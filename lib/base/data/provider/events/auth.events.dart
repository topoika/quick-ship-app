part of "../export.provider.dart";

class AuthEvents extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GoogleLogin extends AuthEvents {}

class AuthLogin extends AuthEvents {
  final User user;
  AuthLogin({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthRegister extends AuthEvents {
  final User user;

  AuthRegister({required this.user});

  @override
  List<Object> get props => [user];
}

class GetAuthUser extends AuthEvents {
  final String? token;
  GetAuthUser({this.token});

  @override
  List<Object> get props => [token!];
}

class DeleteUserAccount extends AuthEvents {}

class Logout extends AuthEvents {}

class RequestEmailOtp extends AuthEvents {}

class VerifyEmailOtp extends AuthEvents {
  final String otp;
  final String token;

  VerifyEmailOtp({required this.otp, required this.token});

  @override
  List<Object> get props => [otp, token];
}

class RequestResetPassword extends AuthEvents {
  final String email;

  RequestResetPassword({required this.email});

  @override
  List<Object> get props => [email];
}
