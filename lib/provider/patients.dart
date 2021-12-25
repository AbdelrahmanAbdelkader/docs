import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample/provider/patient.dart';

class PatientsProv extends ChangeNotifier {
  List<Patient> _patients = [];

  List<Patient> get patients {
    return _patients;
  }

  void addPatient(Map newPatient) {
    print("ss");
    print(newPatient);
    _patients.add(
      Patient()
        ..address = newPatient['adress']
        ..doctor = newPatient['Doctor']
        ..ill = newPatient['illnessType']
        ..latest = newPatient['latest']
        ..name = newPatient['name']
        ..phone = newPatient['phoneNum']
        ..source = newPatient['source']
        // ..vol = newPatient['volName']
        ..date = newPatient['date']
        ..state = newPatient['state'],
    );
    print("kk");
    print(_patients);
  }

  Future<void> refresh() async {
    _patients=[];
    final database = FirebaseDatabase.instance;
    final ref = await database.ref().child("patients").get();
    if (ref.exists) {
      (ref.value as Map).values.forEach((element) {
        addPatient(element);
      });
    }
    print(_patients);
  }
}
