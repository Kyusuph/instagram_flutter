import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String username;
  final String postId;
  final String commentId;
  final String uid;
  final datePublished;
  final String description;
  final String postUrl;
  final String profileImage;
  final likes;

  Comment({
    required this.username,
    required this.commentId,
    required this.profileImage,
    required this.datePublished,
    required this.description,
    required this.uid,
    required this.postUrl,
    required this.postId,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "username": username,
        "uid": uid,
        "datePublished": datePublished,
        "likes": likes,
        "postUrl": postUrl,
        "profileImage": profileImage,
        "description": description,
        "postId": postId,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    final snapshot = (snap.data() as Map<String, dynamic>);
    return Comment(
      commentId: snapshot['commentId'],
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

  static Comment fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      username: json['username'],
      profileImage: json['profileImage'],
      likes: json['likes'],
      uid: json['uid'],
      datePublished: json['datePublished'],
      postId: json['postId'],
      postUrl: json['postUrl'],
      description: json['description'],
    );
  }
}
