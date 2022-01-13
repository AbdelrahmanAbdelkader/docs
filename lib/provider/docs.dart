import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/provider/doc.dart';
import 'package:sample/provider/patients.dart';

class Docs extends ChangeNotifier {
  Map _data = {};
  List<Doc> doctors = [];
  List<Doc> searchedDoctors = [];
  Future<void> refresh(
    Function fun,
    BuildContext context,
    Function(List<Map>) setCurrentDoctors,
  ) async {
    print('refreshDoctors');
    final database = FirebaseDatabase.instance;
    doctors = [];
    DataSnapshot? dataSnap;
    try {
      dataSnap = await database.ref().child("doctors").get();
    } catch (e) {
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
    if (dataSnap!.exists) {
      Map data = dataSnap.value as Map;
      _data = {...data};
      _data.forEach((key, value) {
        doctors.add(
          Doc()
            ..Id = key as String
            ..initData(value)
            ..ref = fun,
        );
      });
      setCurrentDoctors(
        doctors
            .map((e) => {
                  'idDoc': e.Id,
                  'name': e.name,
                })
            .toList(),
      );
    }
  }

  void search(String searchFor, String? byname) {
    print('search');
    searchedDoctors = [];
    doctors.forEach(
      (element) {
        {
          if ((byname == 'الاسم' || byname == null) && searchFor != '') {
            if (element.name.contains(searchFor)) {
              searchedDoctors.add(element);
            }
          }
        }
      },
    );
    notifyListeners();
  }
}
