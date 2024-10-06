part of "../export.provider.dart";

class UserEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateProfile extends UserEvents {
  final User user;
  final File? image;
  final File? verificationFront;
  final File? verificationBack;

  UpdateProfile({
    required this.user,
    this.image,
    this.verificationFront,
    this.verificationBack,
  });

  @override
  List<Object?> get props => [user, image, verificationFront, verificationBack];
}

class FetchUserStats extends UserEvents {}
