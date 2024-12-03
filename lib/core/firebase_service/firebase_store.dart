import 'package:chattest/featuers/contacts/model/user_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../featuers/chat/model/message_model.dart';
import '../../featuers/home/model/room.dart';
import 'firebase_Auth.dart';
import 'notifc.dart';

class FirebaseStoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 1-  update user push token in Firestore
  Future<void> updateUserToken(String userId) async {
    String? token = await Nofifcation().getDevicesToken();
    if (token != null) {
      await firestore.collection('users').doc(userId).update({
        'push_token': token,
      });
    }
  }

  Future CreatUser(UserModel usermodel) async {
    try {
      //2
      usermodel.pushToken = await Nofifcation().getDevicesToken() ?? "";

      await firestore
          .collection("users")
          .doc(usermodel.id)
          .set(usermodel.toJson());
    } catch (e) {
      throw Exception("error create user $e");
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  String get myUid => auth.currentUser!.uid;

  Stream<List<UserModel>> getAllUser() {
    return firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs
          .map((user) => UserModel.fromJson(user.data()))
          .where((user) => user.id != myUid)
          .toList();
    });
  }


  Future createRoom(String userId) async {
    try {
      CollectionReference chatroom = await firestore.collection('rooms');
      final sortedmemers = [myUid, userId]..sort((a, b) => a.compareTo(b));
      QuerySnapshot existChatrooom =
      await chatroom.where('members', isEqualTo: sortedmemers).get();
      if (existChatrooom.docs.isNotEmpty) {
        return existChatrooom.docs.first.id;
      } else {
        final chatroomid = await firestore.collection('rooms').doc().id;
        Room r = Room(
          id: chatroomid,
          createdAt: DateTime.now().toIso8601String(),
          lastMessage: "",
          members: sortedmemers,
          lastMessageTime: DateTime.now().toIso8601String(),
        );
        await firestore.collection('rooms').doc(chatroomid).set(r.toJson());
      }
    } catch (e) {
      return e.toString();
    }
  }

  Stream<List<Room>> getAllRooms() {
    return firestore
        .collection('rooms')
        .where('members', arrayContains: myUid)
        .snapshots()
        .map((snapshot) =>
    snapshot.docs.map((doc) => Room.fromJson(doc.data())).toList()
      ..sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime)));
  }

  Future createMessage(
      String toid, String msg, String roomid) async {
    final msgid = firestore.collection('messages').doc().id;

    Message message = Message(
        id: msgid,
        toId: toid,
        fromId: myUid,
        msg: msg,
        read: false,
        createdAt: DateTime.now().toIso8601String(),
        type: "text"
    );

    DocumentReference myroom = firestore.collection('rooms').doc(roomid);

    await myroom.collection('messages').doc(msgid).set(message.toJson());

    await myroom.update(
        {'last_message': message.msg, 'last_message_time': message.createdAt});

    // 3
    DocumentSnapshot user =
    await firestore.collection('users').doc(message.toId).get();
    String pushtokent = user.get('push_token');
    String username = user.get('name');

    if (pushtokent != null && pushtokent.isNotEmpty) {
      await Nofifcation().senNotifaction(message.msg, username, pushtokent);
    }

  }

  Stream<List<Message>> getMessages(String roomid) {
    return firestore
        .collection('rooms')
        .doc(roomid)
        .collection('messages')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList());
  }
}
