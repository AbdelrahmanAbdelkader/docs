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
    final size= MediaQuery.of(context).size;
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
      body: Stack(
        children: [
           Positioned(
              bottom: 0,
              child: Container(
                  width: size.width,
                  child: Image.asset(
                    'assets/background.png',
                    fit: BoxFit.fill,
                  ))),
          FutureBuilder(
              future: prove.refresh(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return const VolList();
              }),
        ],
      ),
    );
  }
}
