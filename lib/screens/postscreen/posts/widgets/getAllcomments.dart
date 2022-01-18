import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sample/screens/postscreen/posts/normal_post.dart';

import 'comment.dart';

class GetAllComments extends StatefulWidget {
  const GetAllComments(this.postId, this.comments, this.data, {Key? key})
      : super(key: key);
  final String postId;
  final CommentsType comments;
  final Map data;
  @override
  _GetAllCommentsState createState() => _GetAllCommentsState();
}

class _GetAllCommentsState extends State<GetAllComments> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      reverse: true,
      itemCount: (widget.comments == CommentsType.undetail)
          ? min(widget.data.length - 1, 2)
          : widget.data.length,
      itemBuilder: (ctx, i) => Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          ),
        ),
        child: Comment(
          latest: i <= min(widget.data.length - 1, 2),
          comment: widget.data.values.elementAt(i),
        ),
      ),
    );
  }
}
