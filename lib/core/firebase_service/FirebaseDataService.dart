import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../featuers/content/model/user_Model.dart';
import 'firebase_Auth.dart';

class FirebaseDataService {
  final FirebaseFirestore _firestor = FirebaseFirestore.instance;

  Future creatUser(UserModel userprofil) async {
    try {
      await _firestor
          .collection('users')
          .doc(userprofil.id)
          .set(userprofil.toJson());
      print("User secces created with push token ");
    } catch (e) {
      print("error when you created user $e");
    }
  }

  final myuid = FirebaseAuth.instance.currentUser?.uid;
  Stream<List<UserModel>> getAllUsers() {
    return _firestor.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    });
  }

  Stream<List<UserModel>> getAllUsersWithoutme() {
    return _firestor.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .where((user) => user.id != myuid)
          .toList();
    });
  }
}
