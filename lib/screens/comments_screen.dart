import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:instagram_flutter/utils/colors.dart';

class CommentsScreen extends StatefulWidget {
  final User user;
  const CommentsScreen({Key? key, required this.user}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: false,
        backgroundColor: mobileBackgroundColor,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                    widget.user.photoUrl),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: 'Comment as ${widget.user.username}'),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
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
