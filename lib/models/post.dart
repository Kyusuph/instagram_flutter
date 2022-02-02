import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;
  final String postId;
  final String uid;
  final datePublished;
  final String description;
  final String postUrl;
  final String profileImage;
  final likes;

  Post({
    required this.username,
    required this.profileImage,
    required this.datePublished,
    required this.description,
    required this.uid,
    required this.postUrl,
    required this.postId,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "datePublished": datePublished,
        "likes": likes,
        "postUrl": postUrl,
        "profileImage": profileImage,
        "description": description,
        "postId": postId,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    final snapshot = (snap.data() as Map<String, dynamic>);
    return Post(
      username: snapshot['username'],
      profileImage: snapshot['profileImage'],
      likes: snapshot['likes'],
      uid: snapshot['uid'],
      datePublished: snapshot['datePublished'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      description: snapshot['description'],
    );
  }
}
