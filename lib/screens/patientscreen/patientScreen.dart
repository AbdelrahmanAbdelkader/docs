import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/docs.dart';
import 'package:sample/provider/patients.dart';
import 'package:sample/screens/patientscreen/widgets/patient_list.dart';
import '../widgets/app_bar_button.dart';
import 'add_patient_screen/add_patient_screen.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key? key}) : super(key: key);

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  @override
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
          AppBarButton(onPressed: () {
            final account = Provider.of<Account>(context, listen: false);
            final patientsProvider =
                Provider.of<PatientsProv>(context, listen: false);
            final doctorsProvider = Provider.of<Docs>(context, listen: false);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MultiProvider(providers: [
                  ChangeNotifierProvider.value(
                    value: account,
                  ),
                  ChangeNotifierProvider.value(
                    value: patientsProvider,
                  ),
                  ChangeNotifierProvider.value(
                    value: doctorsProvider,
                  ),
                ], child: AddPatientPage()),
              ),
            );
          }),
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
