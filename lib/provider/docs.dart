import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample/provider/doc.dart';

class Docs extends ChangeNotifier {
  Map _data = {};
  List<Doc> doctors = [];
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
}
