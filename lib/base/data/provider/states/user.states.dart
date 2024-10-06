part of "../export.provider.dart";

class UserStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserStates {}

class UserLoading extends UserStates {}

class UserUpdateSuccess extends UserStates {
  final User user;
  UserUpdateSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserStatsLoaded extends UserStates {
  final UserWallet stats;
  UserStatsLoaded({required this.stats});

  @override
  List<Object?> get props => [stats];
}

class UserError extends UserStates {
  final String message;
  UserError({required this.message});

  @override
  List<Object?> get props => [message];
}
