import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  const PostImage({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.greenAccent),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(imagePath)),
    );
  }
}
