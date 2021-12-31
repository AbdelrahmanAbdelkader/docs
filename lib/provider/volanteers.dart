import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sample/provider/volanteer.dart';

class Volanteers extends ChangeNotifier {
  List<Volanteer> _vols = [
    // {
    //   'name': 'mahmoud',
    //   'phone': '01027900425',
    //   'state': 'بنها',
    //   'id': '1',
    // },
    // {
    //   'name': 'mahmoud',
    //   'phone': '01027900425',
    //   'state': 'بنها',
    //   'id': '2',
    // },
    // {
    //   'name': 'mahmoud',
    //   'phone': '01027900425',
    //   'state': 'بنها',
    //   'id': '3',
    // },
    // {
    //   'name': 'mahmoud',
    //   'phone': '01027900425',
    //   'state': 'بنها',
    //   'id': '4',
    // }
  ];
  List<Volanteer> get vols => _vols;
  // void takeData(Map data,bool pharm) {
  //   data.keys.forEach((key) {
  //     (data[key] as Map).forEach((id, value) {

  //       addVol(value);
  //     });
  //     return;
  //   });
  // }
  Future<void> refresh(String role) async {
    _vols = [];
    if (role == 'متطوع غني') {
      final database = FirebaseDatabase.instance;
      final users = await database.ref().child("users").get();
      final activations = await database.ref().child('activation').get();
      if (users.exists) {
        final List<Map> data;
        final patients = await database.ref().child('patients').get();
        data = List.generate((users.value as Map).length, (index) {
          Map userDetail = (users.value as Map).values.elementAt(index);
          String userId = (users.value as Map).keys.elementAt(index);
          String team = (activations.value
              as Map)[(users.value as Map).keys.elementAt(index)]['team'];
          String role = (activations.value
              as Map)[(users.value as Map).keys.elementAt(index)]['role'];
          bool accepted = (activations.value
              as Map)[(users.value as Map).keys.elementAt(index)]['accepted'];
          List<Map> pts = [];
          if (patients.exists) if ((patients.value as Map)[team] != null) {
            pts = List.generate(((patients.value as Map)[team] as Map).length,
                (index) {
              if (((patients.value as Map)[team] as Map)
                      .values
                      .elementAt(index)['volanteerId'] ==
                  userId)
                return {
                  'patientId': ((patients.value as Map)[team] as Map)
                      .keys
                      .elementAt(index),
                  'patientName': ((patients.value as Map)[team] as Map)
                      .values
                      .elementAt(index)['patientName']
                };
              return {};
            });
          }
          pts.removeWhere((element) => element == {});
          return {
            'name': userDetail['userName'],
            'phone': userDetail['phone'],
            'state': userDetail['state'],
            'id': userId,
            'email': userDetail['email'],
            'team': team,
            'accepted': accepted,
            'role': role,
            'patients': pts,
          };
        });
        data.forEach((element) {
          _vols.add(Volanteer()
            ..name = element['name']
            ..state = element['state']
            ..phone = element['phone']
            ..id = element['id']
            ..email = element['email']
            ..team = element['team']
            ..accepted = element['accepted']
            ..role = element['role']
            ..patients = element['patients']);
        });
      }
    }
  }

  // void addVolPharm(Map vol) {
  //   _volsPharm.add(vol);
  //   notifyListeners();
  // }

  // void addVolChem(Map vol) {
  //   _volsChem.add(vol);
  //   notifyListeners();
  // }
}
