import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/patient.dart';
import 'package:sample/screens/patientscreen/widgets/patient_profile_screen/patient_profile_screen.dart';

class PatientListTile extends StatelessWidget {
  PatientListTile({
    Key? key,
    required this.patient,
  }) : super(key: key);
  final Patient patient;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.blue[300],
        child: ListTile(
          leading: Text(
            patient.name,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Text(
            patient.state,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            'اسم المتطوع',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PatientProfileScreen(
                  patient: patient,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
