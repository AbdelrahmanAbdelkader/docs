import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Auth {
  late String id;
  late String _email;
  late String _password;
  final auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance;
  void setEmail(email) {
    _email = email;
  }

  void setPassword(password) {
    _password = password;
  }

  void signIn() async {
    await auth.signInWithEmailAndPassword(email: _email, password: _password);
  }

  void register(String userName, String userPhone, String? team, String? state,
      String role, bool thereAreUsers) async {
    await auth.createUserWithEmailAndPassword(
        email: _email, password: _password);
    await database.ref().child("users").child(auth.currentUser!.uid).set({
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
