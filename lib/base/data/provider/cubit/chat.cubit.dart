part of "../export.provider.dart";

class ChatCubit extends Cubit<ConversationState> {
  ChatCubit() : super(ConversationState.initial());

  void setOtherUser(User user) {
    emit(state.copyWith(otherUser: user));
  }

  void setConversation(Conversation conversation) {
    emit(state.copyWith(conversation: conversation));
  }

  void setMessage(String message) {
    emit(state.copyWith(message: message));
  }

  User? get otherUser => state.otherUser;
  String? get message => state.message;
  Conversation? get conversation => state.conversation;
}


class ConversationState {
  User? otherUser;
  Conversation? conversation;
  String? message;
  ConversationState({
    this.otherUser,
    this.conversation,
    this.message,
  });

  ConversationState copyWith({
    User? otherUser,
    String? message,
    Conversation? conversation,
  }) {
    return ConversationState(
      otherUser: otherUser ?? this.otherUser,
      message: message ?? this.message,
      conversation: conversation ?? this.conversation,
    );
  }

  // factory initial state
  factory ConversationState.initial() {
    return ConversationState(
      otherUser: null,
      conversation: null,
      message: "",
    );
  }
}
