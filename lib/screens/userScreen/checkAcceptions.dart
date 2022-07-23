import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/auth.dart';
import 'package:sample/provider/user.dart';
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
    final auth = FirebaseAuth.instance;
    return Container(
      color: Colors.white,
      child: Consumer<Account>(builder: (context, account, _) {
        return FutureBuilder(
            future: context.read<UserController>().getUserId(context),
            builder: (context, snaps) {
              print(snaps.data);
              if (snaps.connectionState == ConnectionState.waiting)
                return indicator;
              if (snaps.data != null) {
                if ((snaps.data as DataSnapshot).value != null) {
                  print((snaps.data as DataSnapshot).value);
                  account.setPhone(
                      ((snaps.data as DataSnapshot).value as Map)['phone']);
                  account.setName(
                      ((snaps.data as DataSnapshot).value as Map)['userName']);
                  account.setEmail(
                      ((snaps.data as DataSnapshot).value as Map)['email']);
                  account.setState(
                      ((snaps.data as DataSnapshot).value as Map)['state']);

                  account.setTeam(
                      ((snaps.data as DataSnapshot).value as Map)['team']);
                  print('got to stream builder');
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
                          Map data = (snap.data as DatabaseEvent).snapshot.value
                              as Map;

                          (data['accepted'] != null)
                              ? account.setAccepted(data['accepted'])
                              : auth.signOut();
                          if (account.accepted as bool) {
                            return StreamBuilder<DatabaseEvent>(
                                stream: FirebaseDatabase.instance
                                    .ref()
                                    .child('users')
                                    .child(account.id as String)
                                    .child('role')
                                    .onValue,
                                builder: (context, snapshotRole) {
                                  if (snapshotRole.connectionState ==
                                      ConnectionState.waiting)
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  if (snapshotRole.data !=
                                      null) if (snapshotRole
                                          .data!.snapshot.value !=
                                      null) {
                                    account.setRole(snapshotRole
                                        .data!.snapshot.value as String);
                                    return UserScreen();
                                  }
                                  return Scaffold(
                                    body: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'حدث خطأ تواصل مع مسؤول الملف',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 20),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                              },
                                              child: Text('تسجيل خروج'))
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } 
                          // else {
                          //   return GuestScreen(true);
                          // }
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
              }

              return Center(
                child: Dialog(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('network error'),
                        ElevatedButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                            child: Text('try again'))
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}
