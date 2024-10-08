part of "../export.provider.dart";

class NotificationBloc extends Bloc<AppDataEvents, AppDataStates> {
  AppDataRepo repo = AppDataRepo();

  NotificationBloc() : super(InitialAppDataState()) {
    on<FetchNotifications>(fetchNotifications);
    on<SendNotification>(sendNotification);
  }
  void fetchNotifications(event, emit) async {
    emit(LoadingAppDataState());
    try {
      final notifications = await repo.fetchNotifications();
      emit(NotificationsLoadedAppDataState(notifications: notifications));
    } catch (e) {
      emit(ErrorAppDataState(message: e.toString()));
    }
  }

  void sendNotification(event, emit) async {
    repo.sendNotification(notification: event.notification);
  }
}

// FaqBloc
class FaqBloc extends Bloc<AppDataEvents, AppDataStates> {
  AppDataRepo repo = AppDataRepo();

  FaqBloc() : super(InitialAppDataState()) {
    on<FetchFaqs>(fetchFaqs);
  }
  void fetchFaqs(event, emit) async {
    emit(LoadingAppDataState());
    try {
      final faqs = await repo.fetchFaqs();
      emit(FaqsLoadedAppDataState(faqs: faqs));
    } catch (e) {
      emit(ErrorAppDataState(message: e.toString()));
    }
  }
}

// FeedBloc
class FeedBloc extends Bloc<AppDataEvents, AppDataStates> {
  AppDataRepo repo = AppDataRepo();

  FeedBloc() : super(InitialAppDataState()) {
    on<FetchFeeds>(fetchFeeds);
  }
  void fetchFeeds(event, emit) async {
    emit(LoadingAppDataState());
    try {
      final feeds = await repo.fetchFeeds();
      emit(FeedsLoadedAppDataState(feeds: feeds));
    } catch (e) {
      emit(ErrorAppDataState(message: e.toString()));
    }
  }
}
