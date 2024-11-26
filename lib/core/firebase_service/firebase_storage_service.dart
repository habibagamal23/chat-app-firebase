import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'firebase_Auth.dart';

class FirebaseSorageService {
  /// Upload a profile image to Firebase Storage and return the download URL.
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadProfileImage(File file) async {
    try {
      String userId = FirebaseAuthService().myUid;
      final fileExtension = file.path.split('.').last;
      final storagePath =
          'users/$userId/profile_images/profile_image.$fileExtension';
      final ref = _firebaseStorage.ref().child(storagePath);
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }
}
