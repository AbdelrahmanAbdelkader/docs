import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Vols extends ChangeNotifier {
  List<Map> _volsPharm = [
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
  List<Map> _volsChem = [];
  List<Map> get volsPharm {
    return _volsPharm;
  }

  List<Map> get volsChem {
    return _volsChem;
  }

  // void takeData(Map data,bool pharm) {
  //   data.keys.forEach((key) {
  //     (data[key] as Map).forEach((id, value) {

  //       addVol(value);
  //     });
  //     return;
  //   });
  // }

  Future<void> refresh() async {
    final database = FirebaseDatabase.instance;
    _volsPharm = [];
    _volsChem = [];
    final ref1 = await database.ref().child("طب:data").get();
    final ref2 = await database.ref().child("صيدلة:data").get();
    final ref3 = await database.ref().child('activation').get();
    print(ref1.value);
    print(ref2.value);
    print(ref3.value);
    if (ref1.exists) {
      (ref1.value as Map).keys.forEach((element) {
        addVolPharm({
          ...(ref1.value as Map)[element],
          "accepted": (ref3.value as Map)[element]['accepted'],
          "uid": element,
        });
      });
    }
    if (ref2.exists) {
      (ref2.value as Map).keys.forEach((element) {
        addVolChem({
          ...(ref2.value as Map)[element],
          "accepted": (ref3.value as Map)[element]['accepted'],
          "uid": element,
        });
      });
    }
    print(_volsChem);
    print(_volsPharm);
  }

  void addVolPharm(Map vol) {
    _volsPharm.add(vol);
    notifyListeners();
  }

  void addVolChem(Map vol) {
    _volsChem.add(vol);
    notifyListeners();
  }
}
