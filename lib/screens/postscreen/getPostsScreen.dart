import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sample/screens/postscreen/posts_screen.dart';

class GetPostsScreen extends StatelessWidget {
  const GetPostsScreen({Key? key}) : super(key: key);
  Future<List<Map<String, dynamic>>> getPosts() async {
    List<Map<String, dynamic>> data = [];
    final posts = await FirebaseDatabase.instance.ref().child('posts').get();

    if (posts.value != null) {
      (posts.value as Map).forEach((key, value) {
        data.add({'key': key, 'type': value['type']});
      });
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: getPosts(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return PostsScreen(snap.data as List<Map<String, dynamic>>);
          }
        });
  }
}
