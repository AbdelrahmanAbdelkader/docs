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
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: (DateTime.parse(DateTime.now().toString())
                    .difference(
                      DateTime.parse(
                        (patient.latest!.values.first as Map)['date'],
                      ),
                    )
                    .inDays <
                30)
            ? Colors.teal.withOpacity(.5)
            : Colors.deepOrange.withOpacity(.3),
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    patient.name as String,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    patient.state as String,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'اسم المتطوع',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
