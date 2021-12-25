import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/patient.dart';
import 'package:sample/provider/patients.dart';
import 'package:sample/screens/patientscreen/widgets/patient_list_tile.dart';

class PatientList extends StatelessWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final proveFalse = Provider.of<PatientsProv>(context, listen: false);
    final proveTrue = Provider.of<PatientsProv>(context);
    return FutureBuilder(
      future: proveFalse.refresh(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (proveTrue.patients.isNotEmpty) {
          print(proveTrue.patients);
          return ListView(
            children: proveTrue.patients
                .map((e) => PatientListTile(
                      patient: e,
                    ))
                .toList(),
          );
        }
        return const Center(
          child: Text('لا توجد حالات'),
        );
      },
    );
  }
}
