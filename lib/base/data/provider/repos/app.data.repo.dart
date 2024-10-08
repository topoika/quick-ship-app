part of "../export.provider.dart";

class AppDataRepo extends NetworkRequest {
  // fetchNotifications
  Future<List<AppNotifications>> fetchNotifications() async {
    try {
      final response = await get('data/user-notifications');
      if (response['success'] == true) {
        return (response['data'] as List)
            .map((e) => AppNotifications.fromMap(e))
            .toList();
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // fetchFaqs
  Future<List<FAQ>> fetchFaqs() async {
    try {
      final response = await get('data/faqs');
      if (response['success'] == true) {
        return (response['data'] as List).map((e) => FAQ.fromMap(e)).toList();
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // fetchFeeds
  Future<List<Feed>> fetchFeeds() async {
    try {
      final response = await get('data/feeds');
      if (response['success'] == true) {
        return (response['data'] as List).map((e) => Feed.fromMap(e)).toList();
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  void sendNotification({required AppNotifications notification}) async {
    log(json.encode(notification.toMap()).toString());
    await post("user/send-notification", notification.toMap());
  }
}
