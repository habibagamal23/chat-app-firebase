import 'package:chattest/featuers/login/model/loginBody.dart';
import 'package:chattest/featuers/register/model/registerbody.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthontion {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> login(LoginBody loginbody) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: loginbody.email, password: loginbody.pass);

      return credential.user;
    } catch (e) {
      throw Exception("Error to login user $e");
    }
  }

  Future<User?> register(RegisterBody registerbody) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: registerbody.email,
        password: registerbody.pass,
      );

      final user = credential.user;

      if (user != null) {
        await user.updateDisplayName(registerbody.username);
        await user.reload();
      }

      return user;
    } catch (e) {
      throw Exception("Regiser error $e");
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
