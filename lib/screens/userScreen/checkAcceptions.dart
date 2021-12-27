import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/bottomnav.dart';
import 'package:sample/screens/guestscreen/guestscreen.dart';
import 'package:sample/screens/userScreen/UserScreenAccepted.dart';

class CheckAcception extends StatelessWidget {
  const CheckAcception({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context, listen: false);
    account.setId(FirebaseAuth.instance.currentUser!.uid);
    return Container(
      color: Colors.white,
      child: StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref()
            .child('activation')
            .child(account.id as String)
            .onValue,
        builder: (ct, snap) {
          print("ss");
          if (snap.data != null) if (snap.connectionState ==
              ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snap.data != null) {
            if ((snap.data as DatabaseEvent).snapshot.exists) {
              Map data = (snap.data as DatabaseEvent).snapshot.value as Map;
              account.setRole(data['role']);
              account.setTeam(data['team']);
              account.setAccepted(data['accepted']);
              if (account.accepted as bool) {
                return UserScreen();
              } else {
                return GuestScreen(true);
              }
            }
          }
          return Container(
            child: Center(
              child: TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text("خروج"),
              ),
            ),
          );
        },
      ),
    );
  }
}
