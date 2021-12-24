import 'package:flutter/material.dart';
import 'package:sample/screens/patientscreen/widgets/patient_list.dart';
import '../widgets/app_bar_button.dart';
import 'add_patient_screen/add_patient_screen.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحالات'),
        actions: [
          AppBarButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddPatientPage(),
              ),
            ),
          )
        ],
      ),
      body: const PatientList(),
    );
  }
}
