import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sample/provider/auth.dart';
import 'package:sample/provider/bottom_navigationController.dart';
import 'package:sample/provider/docs/docs.dart';
import 'package:sample/provider/patients/patients.dart';
import 'package:sample/model/role_provider.dart';

import 'package:sample/provider/volanteers.dart';
import 'package:sample/screens/authscreen/authscreen.dart';
import 'package:sample/screens/authscreen/checkFirstEmailBeforeAuth.dart';
import 'package:sample/screens/userScreen/UserScreenAccepted.dart';
import 'package:sample/screens/userScreen/checkAcceptions.dart';
import '../guestscreen/guestscreen.dart';
import '../userScreen/widgets/loadingIndicator.dart';

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
          print('loading userChanges');
          return LoadingIndicator(
            label: 'البحث عن المستخدم',
            postion: 1,
          );
          ;
        }

        if (snapshot.hasData) {
          if (snapshot.data!.isAnonymous) {
            // return const GuestScreen(false);
            return Container(
              color: Colors.white,
            );
          }
          return CheckAcception();
        }
        return CheckFirstEmailBeforeAuth();
      },
    );
  }
}
