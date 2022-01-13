import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({Key? key, required this.comment, required this.latest})
      : super(key: key);
  final Map comment;
  final bool latest;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              comment['name'],
              style: TextStyle(
                color: Colors.green,
                fontSize: 18,
              ),
            ),
            Spacer(),
            Text(
              comment['date'],
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 18,
              ),
            ),
          ],
        ),
        Text(
          comment['content'],
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        (!latest) ? Divider() : Container(),
      ],
    );
  }
}
