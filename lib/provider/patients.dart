import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample/provider/patient.dart';

class PatientsProv extends ChangeNotifier {
  List<Patient> _patients = [];
  List<Map> _currentDoctors = [];
  List<Map> get currentDoctors => _currentDoctors;
  List<Patient> get patients {
    return _patients;
  }

  void addPatient(Map newPatient, String volanteerName) {
    _patients.add(Patient()
      ..volId = newPatient['volanteerId']
      ..volName = newPatient['volanteerName']
      ..name = newPatient['patientName']
      ..docId = newPatient['docId']
      ..doctor = newPatient['docName']
      ..illnessType = newPatient['illnessType']
      ..illnesses = [
        ...(newPatient['illnesses'] as Map).keys.map((e) => {
              'id': e,
              'المرض': newPatient['illnesses'][e]['المرض'],
              'القيمة': newPatient['illnesses'][e]['القيمة'],
            })
      ]
      ..address = newPatient['adress']
      ..phone = newPatient['phone']
      ..source = newPatient['source']
      ..latests = [
        ...(newPatient['latests'] as Map).keys.map((e) => {
              'id': e,
              'date': newPatient['latests'][e]['date'],
              'title': newPatient['latests'][e]['title'],
            })
      ]
      ..state = newPatient['state']
      ..date = newPatient['date']);
  }

  Future<void> refresh(String team, String role) async {
    _patients = [];
    final database = FirebaseDatabase.instance;
    final users = await database.ref().child('users').get();
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
        addPatient(
            element, (users.value as Map)[element['volanteerId']]['name']);
      });
    }
    if (ref2!.exists) {
      (ref2.value as Map).values.forEach((element) {
        addPatient(
            element, (users.value as Map)[element['volanteerId']]['name']);
      });
    }
  }

  void setCurrentDoctors(List<Map> doctors) {
    _currentDoctors = doctors;
    notifyListeners();
  }
}
