part of "../export.provider.dart";

class UserBloc extends Bloc<UserEvents, UserStates> {
  UserRepo repo = UserRepo();
  UserBloc() : super(UserInitial()) {
    on<UpdateProfile>(updateProfile);
  }
  void updateProfile(event, emit) async {
    emit(UserLoading());
    try {
      final user = await repo.updateProfile(
          user: event.user,
          image: event.image,
          verificationFront: event.verificationFront,
          verificationBack: event.verificationBack);
      emit(UserUpdateSuccess(user: user));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}

class UserStatsBloc extends Bloc<UserEvents, UserStates> {
  UserRepo repo = UserRepo();
  UserStatsBloc() : super(UserInitial()) {
    on<FetchUserStats>(fetchUserStats);
  }

  void fetchUserStats(event, emit) async {
    emit(UserLoading());
    try {
      final stats = await repo.fetchUserStats();
      emit(UserStatsLoaded(stats: stats));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
