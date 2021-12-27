import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/bottomnav.dart';

import 'UserScreenAccepted.dart';

class CheckRole extends StatelessWidget {
  const CheckRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseDatabase.instance
            .ref()
            .child('activation')
            .child(FirebaseAuth.instance.currentUser!.uid)
            .child('role')
            .onValue,
        builder: (context, snapshot) {
          // print(FirebaseAuth.instance.currentUser!.uid);
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return UserScreen(
              (snapshot.data as DatabaseEvent).snapshot.value as String);
        });
  }
}
