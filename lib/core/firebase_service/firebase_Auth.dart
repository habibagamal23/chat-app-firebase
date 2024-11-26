import 'dart:io';

import 'package:chattest/featuers/login/model/loginBody.dart';
import 'package:chattest/featuers/register/model/registerbody.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../featuers/content/model/user_Model.dart';
import 'FirebaseDataService.dart';
import 'firebase_storage_service.dart';

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

  Future<User?> register(RegisterBody registerbody, {File? imageFile}) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: registerbody.email,
        password: registerbody.pass,
      );

      final user = credential.user;

      /// Upload profile image if provided
      if (imageFile != null) {
        await FirebaseSorageService().uploadProfileImage(imageFile);
      }

      if (user != null) {
        await user.updateDisplayName(registerbody.username);
        await user.reload();

        /// to store this in store
        UserModel userProfile = UserModel(
            id: user.uid,
            name: registerbody.username,
            email: registerbody.email,
            about: "is new user ",
            phoneNumber: registerbody.phone,
            createdAt: DateTime.now().toIso8601String(),
            lastActivated: DateTime.now().toIso8601String(),
            pushToken: "",
            online: true);
        await FirebaseDataService().creatUser(userProfile);
      }

      return user;
    } catch (e) {
      throw Exception("Regiser error $e");
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print('Error logging out: $e');
      throw e;
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
