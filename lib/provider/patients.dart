import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sample/provider/patient.dart';

class PatientsProv extends ChangeNotifier {
  List<Patient> _patients = [];
  List<Map> _currentDoctors = [];
  List<Map> get currentDoctors => _currentDoctors;
  List<Patient> get patients {
    return _patients;
  }

  void clear() {
    _patients = [];
  }

  void addPatient(Map newPatient) {
    print('ss');
    print(Patient()
      // ..team = newPatient['team']
    //   ..images = (newPatient['images'] != null)
    //       ? [...newPatient['images'] as List]
    //       : []
    //   ..volId = newPatient['volanteerId']
    //   ..volName = newPatient['volanteerName']
    //   ..name = newPatient['patientName']
    //   ..nationalId = newPatient['nationaId']
    //   ..docId = newPatient['docId']
    //   ..doctor = newPatient['docName']
    //   ..illnessType = newPatient['illnessType']
    //   ..illness = newPatient['illness']
    //   ..costs = [
    //     if ((newPatient['costs']) != null)
    //       ...(newPatient['costs'] as Map).keys.map((e) => {
    //             'id': e,
    //             'التكليف': newPatient['costs'][e]['التكليف'],
    //             'القيمة': newPatient['costs'][e]['القيمة'],
    //           })
    //   ]
    //   ..address = newPatient['adress']
    //   ..phone = newPatient['phone']
    //   ..source = newPatient['source']
    //   ..availableForGuests = newPatient['availableForGuests']
    //   ..latests = [
    //     if (newPatient['latests'] != null)
    //       ...(newPatient['latests'] as Map).keys.map((e) => {
    //             'id': e,
    //             'date': newPatient['latests'][e]['date'],
    //             'title': newPatient['latests'][e]['title'],
    //           })
    //   ]
    //   ..state = newPatient['state']
    //   ..date = newPatient['date']
    );
    _patients.add(Patient()
      ..team = newPatient['team']
      ..images = (newPatient['images'] != null)
          ? [...newPatient['images'] as List]
          : []
      ..volId = newPatient['volanteerId']
      ..volName = newPatient['volanteerName']
      ..name = newPatient['patientName']
      ..nationalId = newPatient['nationaId']
      ..docId = newPatient['docId']
      ..doctor = newPatient['docName']
      ..illnessType = newPatient['illnessType']
      ..illness = newPatient['illness']
      ..costs = [
        if ((newPatient['costs']) != null)
          ...(newPatient['costs'] as Map).keys.map((e) => {
                'id': e,
                'التكليف': newPatient['costs'][e]['التكليف'],
                'القيمة': newPatient['costs'][e]['القيمة'],
              })
      ]
      ..address = newPatient['adress']
      ..phone = newPatient['phone']
      ..source = newPatient['source']
      ..availableForGuests = newPatient['availableForGuests']
      ..latests = [
        if (newPatient['latests'] != null)
          ...(newPatient['latests'] as Map).keys.map((e) => {
                'id': e,
                'date': newPatient['latests'][e]['date'],
                'title': newPatient['latests'][e]['title'],
              })
      ]
      ..state = newPatient['state']
      ..date = newPatient['date']
    );
  }

  Future<void> refresh(String team, String role, BuildContext context) async {
    _patients = [];
    final database = FirebaseDatabase.instance;
    var ref;
    try {
      ref = await database.ref().child("patients").child(team).get();
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
            height: 200,
            child: Center(child: Text('معلش غيرك اشطر')),
          ),
        ),
      );
    }
    DataSnapshot? ref2;
    if (role == 'متطوع غني')
      try {
        ref2 = await database
            .ref()
            .child("patients")
            .child((team == 'طب') ? 'صيدلة' : 'طب')
            .get();
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              height: 200,
              child: Center(child: Text('sorry bro')),
            ),
          ),
        );
      }
    else
      ref2 = null;
    if (ref.exists) {

      (ref.value as Map).values.forEach((element) {
        print(element);
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
              .isAfter(DateTime.parse(element.latests[i]['date'] as String))) {
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
