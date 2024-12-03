import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chattest/core/firebase_service/firebase_store.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'model/message_model.dart';

part 'chat_state.dart';
class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.firebaseStoreService) : super(ChatInitial());

  final FirebaseStoreService firebaseStoreService;
  final TextEditingController messageController = TextEditingController();
  StreamSubscription<List<Message>>? messgessub;

  String roommyId = "";


  // Fetch messages for a room
  Future<void> fetchMessages(String roomId) async {
    emit(MessagesLoading());
    try {
      roommyId = roomId;
      messgessub = firebaseStoreService.getMessages(roomId).listen(
            (messages) {
          emit(MessagesSuccess(messages));
        },
        onError: (e) {
          emit(MessagesError("Error fetching messages: $e"));
        },
      );
    } catch (e) {
      emit(MessagesError("Failed to load messages: $e"));
    }
  }

  // Send a message to a specific user
  Future<void> sendMessage(String toid) async {
    try {
      String msg = messageController.text;
      if (msg.isEmpty) {
        emit(MessagesError("Message cannot be empty"));
        return;
      }

      await firebaseStoreService.createMessage(toid, msg, roommyId);

      // Clear the message input field after sending
      messageController.clear();

      // Refresh messages after sending
      await fetchMessages(roommyId);
    } catch (e) {
      emit(MessagesError("Failed to send message: $e"));
    }
  }

  @override
  Future<void> close() {
    messgessub?.cancel();
    return super.close();
  }
}

