import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sample/screens/guestscreen/guestscreen.dart';
import 'package:sample/screens/userScreen/UserScreenAccepted.dart';

class CheckAcception extends StatelessWidget {
  const CheckAcception({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<DataSnapshot> checkAccept() async {
      final ref = await FirebaseDatabase.instance
          .ref()
          .child('vol')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .get();
      return ref;
    }

    return FutureBuilder(
      future: checkAccept(),
      builder: (ct, snap) {
        if (snap.connectionState !=
            ConnectionState.waiting) if ((snap.data as DataSnapshot).exists)
          print((snap.data as DataSnapshot).value);
        if (snap.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snap.data != null) {
          if (((snap.data as DataSnapshot).value as Map)['accepted'] as bool) {
            return UserScreen();
          } else {
            return GuestScreen(true);
          }
        }
        return Container();
      },
    );
  }
}
