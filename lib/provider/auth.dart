import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Auth extends ChangeNotifier {
  late String id;
  late String _email;
  late String _password;
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance;

  String? userTeamDropDownBottonValue;
  setUserTeamDropDownBottonValue(String v) {
    userTeamDropDownBottonValue = v;
    notifyListeners();
  }

  String? userSpecialityDropDownBottonValue;
  setUserSpecialityDropDownButtonValue(String v) {
    userSpecialityDropDownBottonValue = v;
    notifyListeners();
  }

  String? roleDropDownBottonValue;
  setRoleDropDownBottonValue(String v) {
    roleDropDownBottonValue = v;
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

  void setEmail(email) {
    _email = email;
  }

  void setPassword(password) {
    _password = password;
  }

  void signInFun() async {
    await auth.signInWithEmailAndPassword(email: _email, password: _password);
    id = auth.currentUser!.uid;
  }

  void register(String userName, String userPhone, String? team, String? state,
      String role, bool thereAreUsers) async {
    await auth.createUserWithEmailAndPassword(
        email: _email, password: _password);
    id = auth.currentUser!.uid;
    await database.ref().child("users").child(id).set({
      'userName': userName,
      'phone': userPhone,
      'id': DateTime.now().toString(),
      'email': _email,
      'state': state,
    });
    await database.ref().child('activation').child(auth.currentUser!.uid).set({
      'accepted': !thereAreUsers,
      'role': role,
      'team': team,
    });
  }

  void guest() {
    auth.signInAnonymously();
  }
}
