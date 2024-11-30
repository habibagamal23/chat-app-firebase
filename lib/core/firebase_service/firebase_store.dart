import 'package:chattest/featuers/contacts/model/user_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future CreatUser(UserModel usermodel) async {
    try {
      await firestore
          .collection("users")
          .doc(usermodel.id)
          .set(usermodel.toJson());
    } catch (e) {
      throw Exception(" crete error $e");
    }
  }
}
