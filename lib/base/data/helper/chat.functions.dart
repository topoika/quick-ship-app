part of "../data.dart";

FirebaseFirestore db = FirebaseFirestore.instance;
String conversationId(int id) {
  final sortedNumbers = [activeUser.value.id!, id]..sort();
  return '${sortedNumbers[0]}_conversation_${sortedNumbers[1]}';
}

class ChatFunctions {
  // collection name
  final String chatsColl = 'chats';
  final String messagesColl = 'messages';
  // get conversation id

  Future<Conversation> getConversation(int id) async {
    String convId = conversationId(id);
    try {
      DocumentSnapshot doc = await db.collection(chatsColl).doc(convId).get();
      if (doc.exists) {
        return Conversation.fromMap(doc.data() as Map<String, dynamic>);
      }
      return Conversation();
    } catch (e) {
      return Conversation();
    }
  }

  // Create a new conversation
  Future<Conversation> createConvo(Conversation convo, Message msg) async {
    final WriteBatch batch = db.batch();
    try {
      DocumentReference convDoc = db.collection(chatsColl).doc(convo.id);
      batch.set(convDoc, convo.toMap());
      DocumentReference messDoc = db.collection(messagesColl).doc();
      batch.set(messDoc, msg.toMap());
      msg.id = messDoc.id;
      batch.update(messDoc, {
        "id": messDoc.id,
        "createdAt": FieldValue.serverTimestamp(),
      });
      batch.update(convDoc, {
        "updatedAt": FieldValue.serverTimestamp(),
        "createdAt": FieldValue.serverTimestamp(),
        "unreadMessages": getUnreadMessages(convo, msg.id),
      });
      await batch.commit();
      final convData = await convDoc.get();
      return Conversation.fromMap(convData.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  // Add a new message to a conversation
  // Add message to new chat
  Future<void> addMessage(Conversation convo, Message msg) async {
    final WriteBatch batch = db.batch();
    try {
      DocumentReference convDoc = db.collection(chatsColl).doc(convo.id);
      DocumentReference messDoc = db.collection(messagesColl).doc();
      batch.set(messDoc, msg.toMap());
      msg.id = messDoc.id;
      batch.update(messDoc, {
        "id": msg.id,
        "createdAt": FieldValue.serverTimestamp(),
      });

      batch.update(convDoc, {
        "lastMessage": msg.text,
        "updatedAt": FieldValue.serverTimestamp(),
        "unreadMessages": getUnreadMessages(convo, msg.id),
      });
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  // get unread message
  Map<String, List<dynamic>> getUnreadMessages(convo, mgsId) {
    Map<String, List<dynamic>> result = {};
    int myId = activeUser.value.id!;
    int otherId = convo.involved!.firstWhere((i) => i != myId);
    if (convo.unreadMessages == null) {
      result[myId.toString()] = [];
      result[otherId.toString()] = [mgsId];
    } else {
      List<dynamic> hisUnread = convo.unreadMessages[otherId.toString()] ?? [];
      hisUnread.add(mgsId);
      result[otherId.toString()] = hisUnread;
      result[myId.toString()] = [];
    }
    return result;
  }

  // get conversations messages
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessageStream(String id) {
    return db
        .collection(messagesColl)
        .where('convoId', isEqualTo: id)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  void clearUnreadMessages(Conversation convo) {
    int myId = activeUser.value.id!;
    int otherId = convo.involved!.firstWhere((i) => i != myId);
    List<dynamic> hisUnread = convo.unreadMessages[otherId.toString()] ?? [];
    db.collection(chatsColl).doc(convo.id).update({
      "unreadMessages": {myId.toString(): [], otherId.toString(): hisUnread},
    });
  }

// Get user conversations
  Stream<QuerySnapshot<Map<String, dynamic>>> getConversations() {
    return db
        .collection(chatsColl)
        .where('involved', arrayContains: activeUser.value.id)
        .orderBy("updatedAt", descending: true)
        .snapshots();
  }

  AppNotifications getNotification(Message msg, int userId) {
    return AppNotifications(
      type: "message",
      title: "Message from: ${activeUser.value.name}",
      body: msg.text,
      itemId: userId,
      senderId: activeUser.value.id,
      userId: userId,
    );
  }
}

Future messageUser({required BuildContext context, required User user}) async {
  await ChatFunctions().getConversation(user.id!).then((val) {
    context.read<ChatCubit>().setConversation(val);
    context.read<ChatCubit>().setOtherUser(user);
    Navigator.pushReplacementNamed(context, AppRoutes.conversationPage,
        arguments: false);
  });
}
