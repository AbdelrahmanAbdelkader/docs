import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/bottomnav.dart';
import 'package:sample/screens/docscreen/doc_page.dart';
import 'package:sample/screens/patientscreen/patientScreen.dart';
import 'package:sample/screens/volscreen/volscreen.dart';

import '../../helpers/docicon.dart';

class UserScreen extends StatelessWidget {
  UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final current = Provider.of<BottomNav>(context).current;
    final bottomnav = Provider.of<BottomNav>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseAuth.instance.signOut(),
      ),
      body: (current == 0)
          ? DocList()
          : (current == 1)
              ? PatientScreen()
              : VolScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current,
        onTap: (v) => bottomnav.set(v),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              DocIcons.doctor,
            ),
            label: 'الدكاترة',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notes,
            ),
            label: 'الابحاث',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'المتطوعين',
          ),
        ],
      ),
    );
  }
}
