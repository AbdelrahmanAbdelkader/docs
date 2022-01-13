import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sample/screens/postscreen/posts_screen.dart';

class GetPostsScreen extends StatelessWidget {
  const GetPostsScreen({Key? key}) : super(key: key);
  Future<List<Map>> downloadImages(
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? posts) async {
    List<Map> data = [];
    if (posts != null) {
      posts.forEach((element) {
        Map post = {};
        List<File> files = [];
        (element.data()['images'] as List).forEach((e) async {
          print(e);
          final sna = await FirebaseStorage.instance
              .ref()
              .child('posts')
              .child(e)
              .getDownloadURL();
          File file = File(sna);
          files.add(file);
        });
        post = {'images': files};
        data.add(post);
      });
    }
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapdata) {
        if (snapdata.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        return FutureBuilder(
            future: downloadImages(snapdata.data!.docs),
            builder: (cont, snap) => PostsScreen());
      },
    );
  }
}
