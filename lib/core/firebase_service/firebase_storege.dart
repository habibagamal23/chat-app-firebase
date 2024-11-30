import 'dart:io';

import 'package:chattest/core/firebase_service/firebase_Auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final storage = FirebaseStorage.instance;

  Future<String> ProfileImage(File Imageprofile) async {
    final exiamge = Imageprofile.path.split(".").last;
    final userid = FirebaseAuthService().myUid;
    final pathstorge = "users/$userid/profilesimage/profileimage.$exiamge";
    try {
      final storageRef = await storage.ref().child(pathstorge);
      await storageRef.putFile(Imageprofile);
      return await storageRef.getDownloadURL();
    } catch (e) {
      throw Exception("error when ulpoad profile image $e");
    }
  }
}
