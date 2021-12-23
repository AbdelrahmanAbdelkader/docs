import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample/provider/patient.dart';

class PatientsProv extends ChangeNotifier {
  List<Patient> _patients = [];

  List<Patient> get patients {
    return _patients;
  }

  void addPatient(Map newPatient) {
    print(newPatient['illnesses']);
    _patients.add(Patient()
      ..address = newPatient['adress']
      ..doctor = newPatient['Doctor']
      ..ill = newPatient['illnesses']
      ..latest = newPatient['latest']
      ..name = newPatient['name']
      ..phone = newPatient['phoneNum']
      ..source = newPatient['source']
      ..vol = newPatient['volName']
      ..date = newPatient['date']);
    print("kk");
    print(_patients);
  }

  Future<void> refresh() async {
    _patients = [];
    print('z');
    final database = FirebaseDatabase.instance;
    final ref = await database.ref().child("patients").get();
    if (ref.exists) {
      (ref.value as Map).values.forEach((element) {
        addPatient(element);
      });
    }
  }
}
