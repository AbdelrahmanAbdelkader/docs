import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Auth extends ChangeNotifier {
  String? id;
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance;

  String? userTeamDropDownBottonValue;
  setUserTeamDropDownBottonValue(String v) {
    userTeamDropDownBottonValue = v;
    notifyListeners();
  }

  String? roleDropDownBottonValue;
  setRoleDropDownBottonValue(String v) {
    roleDropDownBottonValue = v;
    notifyListeners();
  }

  String? stateDropDownBottonValue;
  setstateDropDownBottonValue(String v) {
    stateDropDownBottonValue = v;
    notifyListeners();
  }

  bool signIn = true;
  changeSigning() {
    signIn = !signIn;
    notifyListeners();
  }

  bool triedToValidate = false;
  toggleTriedToValidate() {
    triedToValidate = true;
    notifyListeners();
  }

  void printData() {
    print(id);
    print(userTeamDropDownBottonValue);
    print(roleDropDownBottonValue);
    print(stateDropDownBottonValue);
    print(signIn);
    print(triedToValidate);
  }

  void signInFun(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    id = auth.currentUser!.uid;
  }

  void register(
      {required String userName,
      required String userPhone,
      required String email,
      required String password,
      required bool thereAreUsers}) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    id = auth.currentUser!.uid;
    await database.ref().child("users").child(id as String).set({
      'userName': userName,
      'phone': userPhone,
      'email': email,
      'state': stateDropDownBottonValue,
    });
    await database.ref().child('activation').child(auth.currentUser!.uid).set({
      'accepted': !thereAreUsers,
      'role': roleDropDownBottonValue,
      'team': userTeamDropDownBottonValue,
    });
  }

  void guest() {
    auth.signInAnonymously();
  }
}
