import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sample/screens/authscreen/authscreen.dart';

class CheckFirstEmailBeforeAuth extends StatelessWidget {
  const CheckFirstEmailBeforeAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<DataSnapshot> checkIfUsersExist() async {
      DataSnapshot checked =
          await FirebaseDatabase.instance.ref().child('activation').get();
      return checked;
    }

    return FutureBuilder(
        future: checkIfUsersExist(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          bool checked = false;

          if ((snap.data as DataSnapshot).value != null) checked = true;
          return AuthScreen(checked);
        });
  }
}
