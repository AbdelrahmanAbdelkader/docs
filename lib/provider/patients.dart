import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample/provider/patient.dart';

class PatientsProv extends ChangeNotifier {
  List<Patient> _patients = [];

  List<Patient> get patients {
    return _patients;
  }

  void addPatient(Map newPatient) {
    _patients.add(
      Patient()
        ..address = newPatient['adress']
        ..doctor = newPatient['Doctor']
        ..ill = newPatient['illnessType']
        ..latest = newPatient['latest']
        ..name = newPatient['name']
        ..phone = newPatient['phoneNum']
        ..source = newPatient['source']
        ..nationalId = newPatient['nationalId']
        // ..vol = newPatient['volName']
        ..date = newPatient['date']
        ..state = newPatient['state'],
    );
  }

  Future<void> refresh(String team, String role) async {
    _patients = [];
    final database = FirebaseDatabase.instance;
    final ref = await database.ref().child("patients").child(team).get();
    final DataSnapshot? ref2;
    if (role == 'متطوع غني')
      ref2 = await database
          .ref()
          .child("patients")
          .child((team == 'طب') ? 'صيدلة' : 'طب')
          .get();
    else
      ref2 = null;
    if (ref.exists) {
      (ref.value as Map).values.forEach((element) {
        addPatient(element);
      });
    }
    if (ref2!.exists) {
      (ref2.value as Map).values.forEach((element) {
        addPatient(element);
      });
    }
    sortLatest();
  }

  sortLatest() {
    patients.forEach((element) {
      for (int i = 1; i < element.latest!.length; i++) {
        if (DateTime.parse(element.latest![i - 1]['date'])
            .isAfter(element.latest![i]['date'])) {
          Map temp = {};
          temp = element.latest![i - 1]['date'];
          element.latest![i - 1]['date'] = element.latest![i]['date'];
          element.latest![i]['date'] = temp;
        }
      }
    });
  }
}
