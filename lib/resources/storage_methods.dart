import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    bool isPost,
  ) async {
    Reference _ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask _uploadTask = _ref.putData(file);

    TaskSnapshot _snap = await _uploadTask;

    String _downloadUrl = await _snap.ref.getDownloadURL();

    return _downloadUrl;
  }
}
