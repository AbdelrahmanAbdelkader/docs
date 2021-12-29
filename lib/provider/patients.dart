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

  void addPatient(Map newPatient) {
    print(newPatient);
    _patients.add(Patient()
      ..volId = newPatient['volanteerId']
      ..volName = newPatient['volanteerName']
      ..name = newPatient['patientName']
      ..nationalId = newPatient['nationaId']
      ..docId = newPatient['docId']
      ..doctor = newPatient['docName']
      ..illnessType = newPatient['illnessType']
      ..illnesses = [
        if ((newPatient['illnesses']) != null)
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
        if (newPatient['latests'] != null)
          ...(newPatient['latests'] as Map).keys.map((e) => {
                'id': e,
                'date': newPatient['latests'][e]['date'],
                'title': newPatient['latests'][e]['title'],
              })
      ]
      ..state = newPatient['state']
      ..date = newPatient['date']);
    print(patients);
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
        addPatient(element);
      });
      print('ss');
      print(patients);
    }
    if (ref2!.exists) {
      (ref2.value as Map).values.forEach((element) {
        addPatient(element);
      });
    }
    sortLatest();
  }

  sortLatest() {
    for (int i = 0; i < patients.length; i++) {
      for (int y = i + 1; y < patients.length; y++) {
        if (DateTime.parse(patients[y].date as String)
            .isAfter(DateTime.parse(patients[i].date as String))) {
          Patient temp = patients[i];
          patients[i] = patients[y];
          patients[y] = temp;
        }
      }
    }
    patients.forEach((element) {
      for (int i = 0; i < element.latests.length; i++) {
        for (int y = i + 1; i < element.latests.length; y++) {
          if (DateTime.parse(element.latests[y]['date'] as String)
              .isBefore(DateTime.parse(element.latests[i]['date'] as String))) {
            Map temp = element.latests[i];
            element.latests[i] = element.latests[y];
            element.latests[y] = temp;
          }
        }
      }
    });
    // patients.forEach((element) {
    //   for (int i = 1; i < element.latests!.length; i++) {
    //     if (DateTime.parse(element.latests![i - 1]['date'])
    //         .isAfter(element.latests![i]['date'])) {
    //       Map temp = {};
    //       temp = element.latests![i - 1]['date'];
    //       element.latests![i - 1]['date'] = element.latests![i]['date'];
    //       element.latests![i]['date'] = temp;
    //     }
    //   }
    // });
  }

  void setCurrentDoctors(List<Map> doctors) {
    _currentDoctors = doctors;
    notifyListeners();
  }
}
