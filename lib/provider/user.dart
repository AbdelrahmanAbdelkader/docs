import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';

class UserController extends ChangeNotifier {
  String? userId;
  getUserId(BuildContext context) async {
    final account = context.read<Account>();
    account.setId(FirebaseAuth.instance.currentUser!.uid);
    print("got into acception");
    return await FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(account.id as String)
        .get();
  }
}
