import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen(this.authanticated, {Key? key}) : super(key: key);
  final bool authanticated;
  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    if (widget.authanticated)
      WidgetsBinding.instance!.addPostFrameCallback(
          (_) => _scaffoldKey.currentState!.showSnackBar(SnackBar(
                content: Text('Welcome User'),
              )));
  }

  @override
  Widget build(BuildContext context) {
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("u didn't accepted yet")));
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('الحالات'),
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: const [],
      ),
    );
  }
}
