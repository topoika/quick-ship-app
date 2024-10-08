part of "../export.provider.dart";

class AppDataEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNotifications extends AppDataEvents {}

class FetchFaqs extends AppDataEvents {}

class FetchFeeds extends AppDataEvents {}

class SendNotification extends AppDataEvents {
  final AppNotifications notification;

  SendNotification({required this.notification});

  @override
  List<Object?> get props => [notification];
}
