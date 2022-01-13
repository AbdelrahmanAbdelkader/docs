import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Auth extends ChangeNotifier {
  String? id;
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance;

  String? userTeamDropDownBottonValue;
  setUserTeamDropDownBottonValue(String v) {
    print('setTeam');
    userTeamDropDownBottonValue = v;
    notifyListeners();
  }

  String? roleDropDownBottonValue;
  setRoleDropDownBottonValue(String v) {
    print('setRole');
    roleDropDownBottonValue = v;
    notifyListeners();
  }

  String? stateDropDownBottonValue;
  setstateDropDownBottonValue(String v) {
    print('setstate');
    stateDropDownBottonValue = v;
    notifyListeners();
  }

  bool signIn = true;
  changeSigning() {
    print('setsignup');
    signIn = !signIn;
    notifyListeners();
  }

  bool triedToValidate = false;
  toggleTriedToValidate() {
    print('settrytovalidate');
    triedToValidate = true;
    notifyListeners();
  }

  void signInFun(String email, String password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      id = auth.currentUser!.uid;
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text((error as FirebaseAuthException).message.toString())));
    }
  }

  void register(
      {required String userName,
      required String userPhone,
      required String email,
      required String password,
      required bool thereAreUsers,
      required BuildContext context}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      id = auth.currentUser!.uid;
      await database.ref().child("users").child(id as String).set({
        'userName': userName,
        'phone': userPhone,
        'email': email,
        'state': stateDropDownBottonValue,
      });
      await database
          .ref()
          .child('activation')
          .child(auth.currentUser!.uid)
          .set({
        'accepted': !thereAreUsers,
        'role': roleDropDownBottonValue,
        'team': userTeamDropDownBottonValue,
      });
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text((error as FirebaseAuthException).message.toString())));
    }
  }

  void guest(BuildContext context) {
    try {
      auth.signInAnonymously();
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text((error as FirebaseAuthException).message.toString())));
    }
  }

  signOut() {
    auth.signOut();
  }
}
