import 'package:flutter/material.dart';

class CommentTextField extends StatelessWidget {
  CommentTextField({Key? key}) : super(key: key);
  TextEditingController commentTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(width: 1, color: Colors.greenAccent),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'اكتب تعليق',
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                controller: commentTextFieldController,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
