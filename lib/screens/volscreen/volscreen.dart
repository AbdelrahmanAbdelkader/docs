import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/vol.dart';
import 'package:sample/screens/volscreen/widgets/vollist.dart';

class VolScreen extends StatelessWidget {
  const VolScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prove = Provider.of<Vols>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('المتطوعين'),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: FutureBuilder(
          future: prove.refresh(),
          builder: (context, snap) {
            return const VolList();
          }),
    );
  }
}
