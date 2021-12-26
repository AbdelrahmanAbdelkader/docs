import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sample/screens/guestscreen/guestscreen.dart';
import 'package:sample/screens/userScreen/UserScreenAccepted.dart';

class CheckAcception extends StatelessWidget {
  const CheckAcception({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref()
            .child('activation')
            .child(FirebaseAuth.instance.currentUser!.uid)
            .child("accepted")
            .onValue,
        builder: (ct, snap) {
          if (snap.data != null)
            print((snap.data as DatabaseEvent).snapshot.value);
          if (snap.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snap.data != null) {
            if ((snap.data as DatabaseEvent).snapshot.value as bool) {
              return StreamBuilder<Object>(
                  stream: FirebaseDatabase.instance
                      .ref()
                      .child('acrivation')
                      .child(FirebaseAuth.instance.currentUser!.uid)
                      .child('role')
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    if ((snapshot.data as DatabaseEvent).snapshot.value ==
                        'متطوع غني')
                      return UserScreen('متطوع غني');
                    else if ((snapshot.data as DatabaseEvent).snapshot.value ==
                        'مسؤول أبحاث')
                      return UserScreen('مسؤول أبحاث');
                    else if ((snapshot.data as DatabaseEvent).snapshot.value ==
                        'مسؤول دكاترة') return UserScreen('مسؤول أبحاث');
                    return UserScreen('متطوع فقير');
                  });
            } else {
              return GuestScreen(true);
            }
          }
          return Container();
        },
      ),
    );
  }
}
