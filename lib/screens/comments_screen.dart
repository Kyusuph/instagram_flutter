import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/comment.dart';
import 'package:instagram_flutter/models/post.dart';
import 'package:instagram_flutter/resources/firestore_methods.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utilis.dart';
import 'package:instagram_flutter/widgets/comment_card.dart';

class CommentsScreen extends StatefulWidget {
  final Post post;
  const CommentsScreen({Key? key, required this.post}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  Future<void> _postComment() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final res = await FirestoreMethods().postComment(
        post: widget.post,
        description: _descriptionController.text,
      );
      if (res == 'success') {
        showSnapBar(context, 'Posted!');
        setState(() {
          _descriptionController.text = '';
          _isLoading = false;
        });
      } else {
        showSnapBar(context, res);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      showSnapBar(context, e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: false,
        backgroundColor: mobileBackgroundColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.post.postId)
            .collection('comments')
            .orderBy('datePublished', descending: true,)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No comment yet!'),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> json =
                    snapshot.data!.docs[index].data();
                return CommentCard(
                  comment: Comment.fromJson(json),
                );
              });
        },
      ),
      bottomNavigationBar: SafeArea(
        child: _isLoading
            ? const LinearProgressIndicator()
            : Container(
                height: kToolbarHeight,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(widget.post.profileImage),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Comment as ${widget.post.username}',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _postComment,
                      child: const Text(
                        'Post',
                        style: TextStyle(color: blueColor),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
