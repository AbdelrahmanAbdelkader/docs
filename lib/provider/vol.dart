import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Vols extends ChangeNotifier {
  List<Map> _vols = [
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
  List<Map> get vols {
    return _vols;
  }

  void takeData(Map data) {
    data.keys.forEach((key) {
      (data[key] as Map).forEach((id, value) {
        addVol(value);
      });
      return;
    });
  }

  Future<void> refresh() async {
    final database = FirebaseDatabase.instance;
    _vols = [];
    final ref = await database.ref().child("vol").get();
    if (ref.exists) {
      (ref.value as Map).values.forEach((element) {
        addVol(element);
      });
    }
    print(_vols);
  }

  void addVol(Map vol) {
    _vols.add(vol);
    notifyListeners();
  }
}
