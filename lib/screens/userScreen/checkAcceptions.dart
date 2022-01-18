import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/auth.dart';
import 'package:sample/screens/guestscreen/guestscreen.dart';
import 'package:sample/screens/splashscreen/splashscreen.dart';
import 'package:sample/screens/userScreen/UserScreenAccepted.dart';

class CheckAcception extends StatelessWidget {
  CheckAcception({Key? key}) : super(key: key);
  final Widget indicator = Center(
    child: CircularProgressIndicator(),
  );
  @override
  Widget build(BuildContext context) {
    print('checkAcceptionOpened');
    final account = Provider.of<Account>(context, listen: false);
    account.setId(FirebaseAuth.instance.currentUser!.uid);
    final auth = FirebaseAuth.instance;
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: FirebaseDatabase.instance
              .ref()
              .child('users')
              .child(account.id as String)
              .get(),
          builder: (context, snaps) {
            //print(snaps.hasData);
            if (snaps.connectionState == ConnectionState.waiting)
              return indicator;
            if (snaps.hasData) {
              account.setPhone(
                  ((snaps.data as DataSnapshot).value as Map)['phone']);
              account.setName(
                  ((snaps.data as DataSnapshot).value as Map)['userName']);
              account.setEmail(
                  ((snaps.data as DataSnapshot).value as Map)['email']);
              account.setState(
                  ((snaps.data as DataSnapshot).value as Map)['state']);
              //account.printData();
              return StreamBuilder(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child('activation')
                    .child(account.id as String)
                    .onValue,
                builder: (ct, snap) {
                  if (snap.connectionState == ConnectionState.waiting)
                    return indicator;
                  if (snap.data != null) {
                    if ((snap.data as DatabaseEvent).snapshot.exists) {
                      Map data =
                          (snap.data as DatabaseEvent).snapshot.value as Map;

                      (data['role'] != null)
                          ? account.setRole(data['role'])
                          : auth.signOut();
                      (data['team'] != null)
                          ? account.setTeam(data['team'])
                          : auth.signOut();
                      (data['accepted'] != null)
                          ? account.setAccepted(data['accepted'])
                          : auth.signOut();
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
              );
            }
            return Center(
              child: Dialog(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('network error'),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Splash()));
                          },
                          child: Text('try again'))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
