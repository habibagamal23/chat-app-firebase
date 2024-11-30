import 'dart:io';

import 'package:chattest/core/firebase_service/firebase_store.dart';
import 'package:chattest/core/firebase_service/firebase_storege.dart';
import 'package:chattest/featuers/contacts/model/user_Model.dart';
import 'package:chattest/featuers/login/model/loginBody.dart';
import 'package:chattest/featuers/register/model/registerbody.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  String get myUid => auth.currentUser!.uid;

  Future<User?> login(LoginBody loginbody) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: loginbody.email, password: loginbody.pass);

      return credential.user;
    } catch (e) {
      throw Exception("Error to login user $e");
    }
  }

  Future<User?> register(RegisterBody registerbody, {File? image}) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: registerbody.email,
        password: registerbody.pass,
      );

      final user = credential.user;

      /// Upload profile image if provided
      if (image != null) {
        await FirebaseStorageService().ProfileImage(image);
      }

      if (user != null) {
        await user.updateDisplayName(registerbody.username);
        await user.reload();

        /// to store this in store
        var usermodel = UserModel(
            id: user.uid,
            name: registerbody.username,
            email: registerbody.email,
            about: "new user",
            phoneNumber:registerbody.phone,
            createdAt: DateTime.now().toString(),
            lastActivated: DateTime.now().toString(),
            pushToken: "",
            online: true);

      await   FirebaseStoreService().CreatUser(usermodel);
      }

      return user;
    } catch (e) {
      throw Exception("Regiser error $e");
    }
  }

  Future logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw Exception("logout error $e");
    }
  }

  /// Send a password reset email to the given email address.
  /// if u need foreget screen in u app
  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }
}
