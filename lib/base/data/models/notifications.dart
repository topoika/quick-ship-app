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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'type': type,
      'senderId': senderId,
      'itemId': itemId,
      'createdAt': createdAt,
    };
  }

  factory AppNotifications.fromMap(Map<String, dynamic> map) {
    return AppNotifications(
      id: map['id'] != null ? map['id'] as int : null,
      userId:
          map['userId'] != null ? int.parse(map['userId'].toString()) : null,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      senderId: map['senderId'] != null
          ? int.parse(map['senderId'].toString())
          : null,
      itemId:
          map['itemId'] != null ? int.parse(map['itemId'].toString()) : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}
