import 'package:flutter/material.dart';

class Vols extends ChangeNotifier {
  final List<Map> _vols = [
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

  void addVol(Map vol) {
    _vols.add(vol);
    notifyListeners();
  }
}
