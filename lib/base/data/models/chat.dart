part of "../data.dart";

class Conversation {
  String? id;
  String? lastMessage;
  dynamic unreadMessages;
  String? createdAt;
  String? updatedAt;
  List<User>? participants;
  List<int>? involved;
  Conversation({
    this.id,
    this.lastMessage,
    this.unreadMessages,
    this.createdAt,
    this.updatedAt,
    this.participants,
    this.involved,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lastMessage': lastMessage ?? "",
      'unreadMessages': unreadMessages ?? {},
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'participants': participants!.map((x) => x.toChatMap()).toList(),
      'involved': involved,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      id: map['id'] != null ? map['id'] as String : null,
      lastMessage:
          map['lastMessage'] != null ? map['lastMessage'] as String : null,
      unreadMessages: map['unreadMessages'] as dynamic,
      createdAt: map['createdAt'] != null
          ? getTimeFromTimestamp(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? getTimeFromTimestamp(map['updatedAt'])
          : null,
      participants: map['participants'] != null
          ? List<User>.from(
              (map['participants'] as List<dynamic>).map<User?>(
                (x) => User.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      involved: map['involved'] != null
          ? List<int>.from((map['involved'] as List<dynamic>))
          : null,
    );
  }
}

class Message {
  String? id;
  String? convoId;
  String? text;
  int? sendBy;
  String? type;
  String? createdAt;
  Message({
    this.id,
    this.convoId,
    this.text,
    this.sendBy,
    this.type,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'convoId': convoId,
      'text': text,
      'sendBy': sendBy,
      'type': type,
      'createdAt': createdAt,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] != null ? map['id'] as String : null,
      convoId: map['convoId'] != null ? map['convoId'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
      sendBy: map['sendBy'] != null ? map['sendBy'] as int : null,
      type: map['type'] != null ? map['type'] as String : null,
      createdAt: map['createdAt'] != null
          ? getTimeFromTimestamp(map['createdAt'])
          : null,
    );
  }
}
