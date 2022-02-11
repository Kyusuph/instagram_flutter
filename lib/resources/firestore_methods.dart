import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/comment.dart';
import 'package:instagram_flutter/models/post.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future<String> uploadPost({
    required String description,
    required String username,
    required String profileImage,
    required String uid,
    required Uint8List file,
  }) async {
    String res = 'Some error occured';
    try {
      final String photoUrl =
          await _storageMethods.uploadImageToStorage('posts', file, true);
      final postId = const Uuid().v1();
      Post post = Post(
          username: username,
          uid: uid,
          description: description,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profileImage: profileImage,
          likes: []);

      await _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> postComment({
    required Post post,
    required String description,
  }) async {
    String res = 'Some error occured';
    try {
      if (description.isNotEmpty) {
        final commentId = const Uuid().v1();
        Comment comment = Comment(
          username: post.username,
          commentId: commentId,
          uid: post.uid,
          description: description,
          postId: post.postId,
          datePublished: DateTime.now(),
          postUrl: post.postUrl,
          profileImage: post.profileImage,
          likes: [],
        );

        await _firestore
            .collection('posts')
            .doc(post.postId)
            .collection('comments')
            .doc(commentId)
            .set(comment.toJson());
        res = 'success';
      } else {
        res = 'Description is required';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> deletePost({required String postId}) async {
    String res = 'Some error occured';
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
