import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  const PostImage({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;
  Future<String?> getImage() async {
    final file = FirebaseStorage.instance
        .ref()
        .child('posts')
        .child(imagePath)
        .getDownloadURL();
    return file;
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return FutureBuilder(
        future: getImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: LinearProgressIndicator());
          if (snapshot.data != null)
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.greenAccent),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(snapshot.data as String),
            );
          return Text('no image with that url');
        });
>>>>>>> 74962575d8855b553ced22f5e7a2fdba76076498
  }
}
