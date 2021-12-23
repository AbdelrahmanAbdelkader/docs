import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample/provider/doc.dart';

class Docs extends ChangeNotifier {
  Map _data = {};
  List<Doc> doctors = [];
  List<Doc> searchedDoctors = [];
  Future<void> refresh() async {
    final database = FirebaseDatabase.instance;
    doctors = [];
    DataSnapshot dataSnap = await database.ref().child("doctors").get();
    if (dataSnap.exists) {
      Map data = dataSnap.value as Map;
      _data = {...data};
      _data.forEach((key, value) {
        doctors.add(
          Doc()
            ..Id = key as String
            ..initData(value),
        );
      });
    }
  }

  void search(String searchFor, String? byname) {
    searchedDoctors = [];
    doctors.forEach(
      (element) {
        print(element.name);
        {
          if ((byname == 'الاسم' || byname == null) && searchFor != '') {
            print(byname);
            if (element.name.contains(searchFor)) {
              searchedDoctors.add(element);
            }
          } else if (byname == 'التخصص' && searchFor != '') {
            print('ff');
            if ((element.type as String).contains(searchFor)) {
              searchedDoctors.add(element);
            } else
              searchedDoctors.remove(element);
          }
        }
      },
    );
    searchedDoctors.forEach((e) => print(e.name));
    notifyListeners();
  }
}
