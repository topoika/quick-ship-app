part of "../export.provider.dart";

class AppDataStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialAppDataState extends AppDataStates {}

class LoadingAppDataState extends AppDataStates {}

// faqs loaded
class FaqsLoadedAppDataState extends AppDataStates {
  final List<FAQ> faqs;

  FaqsLoadedAppDataState({required this.faqs});

  @override
  List<Object?> get props => [faqs];
}

// notifications loaded
class NotificationsLoadedAppDataState extends AppDataStates {
  final List<AppNotifications> notifications;

  NotificationsLoadedAppDataState({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

// feeds loaded
class FeedsLoadedAppDataState extends AppDataStates {
  final List<Feed> feeds;

  FeedsLoadedAppDataState({required this.feeds});

  @override
  List<Object?> get props => [feeds];
}

// error
class ErrorAppDataState extends AppDataStates {
  final String message;

  ErrorAppDataState({required this.message});

  @override
  List<Object?> get props => [message];
}
