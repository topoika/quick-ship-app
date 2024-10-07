part of "../data.dart";

class AppNotifications {
  int? id;
  int? userId;
  String? title;
  String? body;
  String? type;
  int? senderId;
  int? itemId;
  String? createdAt;

  AppNotifications({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.type,
    this.senderId,
    this.itemId,
    this.createdAt,
  });

  factory AppNotifications.fromMap(Map<String, dynamic> map) {
    return AppNotifications(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as int : null,
      itemId: map['itemId'] != null ? map['itemId'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}
