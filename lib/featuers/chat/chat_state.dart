part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class MessagesLoading extends ChatState {}

final class MessagesSuccess extends ChatState {
  final List<Message> messages;
  MessagesSuccess(this.messages);
}

final class MessagesError extends ChatState {
  final String error;
  MessagesError(this.error);
}