import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signup({
    required String email,
    required String username,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
            // upload profile pick
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

            // add user to authentification
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Save to your database
        _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'email': email,
          'bio': bio,
          'uid': cred.user!.uid,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl
        });
      }

      return 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
