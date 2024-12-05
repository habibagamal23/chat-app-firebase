import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chattest/core/firebase_service/firebase_store.dart';
import 'package:chattest/featuers/chat/model/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.storeService) : super(ChatInitial());
  FirebaseStoreService storeService;

  TextEditingController messageContoller = TextEditingController();

  // 2 fun 1 - get all messges , send message
  StreamSubscription<List<Message>>? streamSubscription;

  var roomId;
  showAllMessages(String roomid) {
    roomId = roomid;
    emit(ChatLoading());
    streamSubscription = storeService.getMessages(roomid).listen((messages) {
      emit(ChatSucces(messages));
    }, onError: (e) {
      emit(ChatError("list chat is err $e"));
    });
  }

  Future sendMessgae(String toId) async {
    try {
      final msg = messageContoller.text;
      if (msg.isEmpty) {
        emit(ChatError(" message is empty"));
        return;
      }
      await storeService.creatmessge(roomId, toId, msg);
// refresh messages
      await showAllMessages(roomId);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    streamSubscription!.cancel();
    messageContoller.dispose();
    // TODO: implement close
    return super.close();
  }
}
