import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample/screens/patientscreen/widgets/patient_list.dart';
import '../widgets/app_bar_button.dart';
import 'add_patient_screen/add_patient_screen.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key? key}) : super(key: key);

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  void setStates() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحالات'),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(Icons.logout),
          ),
          AppBarButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddPatientPage(setStates),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.fill,
              width: size.width,
            ),
          ),
          PatientList(),
        ],
      ),
    );
  }
}
