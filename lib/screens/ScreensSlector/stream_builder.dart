import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/auth.dart';
import 'package:sample/provider/docs.dart';
import 'package:sample/provider/patients.dart';
import 'package:sample/provider/volanteers.dart';
import 'package:sample/screens/authscreen/authscreen.dart';
import 'package:sample/screens/authscreen/checkFirstEmailBeforeAuth.dart';
import 'package:sample/screens/userScreen/UserScreenAccepted.dart';
import 'package:sample/screens/userScreen/checkAcceptions.dart';
import '../guestscreen/guestscreen.dart';

class MainStream extends StatelessWidget {
  MainStream({Key? key}) : super(key: key);

  late final Stream<User?> stream;
  @override
  Widget build(BuildContext context) {
    stream = FirebaseAuth.instance.userChanges();
    return StreamBuilder<User?>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasData) {
          if (snapshot.data!.isAnonymous) {
            return const GuestScreen(false);
          }
          return MultiProvider(providers: [
            ChangeNotifierProvider<Account>(
              create: (context) => Account(),
            ),
            ChangeNotifierProvider<Docs>(
              create: (context) => Docs(),
            ),
            ChangeNotifierProvider<PatientsProv>(
                create: (context) => PatientsProv()),
            ChangeNotifierProvider<Volanteers>(
              create: (context) => Volanteers(),
            ),
          ], child: CheckAcception());
        }
        return ChangeNotifierProvider<Auth>(
            create: (context) => Auth(), child: CheckFirstEmailBeforeAuth());
      },
    );
  }
}
