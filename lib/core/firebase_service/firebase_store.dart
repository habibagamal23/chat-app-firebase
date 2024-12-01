import 'package:chattest/featuers/contacts/model/user_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../featuers/home/model/room.dart';
import 'firebase_Auth.dart';

class FirebaseStoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future CreatUser(UserModel usermodel) async {
    try {
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

  Future creatRoom(String ontherid) async {
    try {
      List<String> members = [myUid, ontherid]..sort();

      CollectionReference chatroom = await firestore.collection("rooms");
      var existroom = await chatroom.where('members', isEqualTo: members).get();
      if (existroom.docs.isNotEmpty) {
        return existroom.docs.first.id;
      } else {
        var roomid = firestore.collection("rooms").doc().id;

        var roomModel = Room(
            id: roomid,
            lastMessage: '',
            members: members,
            lastMessageTime: '',
            createdAt: DateTime.now().toString());
        await firestore.collection("rooms").doc(roomid).set(roomModel.toJson());
      }
    } catch (e) {
      print("Error creating room: $e");
      return '';
    }
  }

  Stream<List<Room>> getMyRooms() {
    return firestore
        .collection("rooms")
        .where('members', arrayContains: myUid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((room) => Room.fromJson(room.data())).toList();
    });
  }
}
