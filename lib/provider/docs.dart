import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/doc.dart';
import 'package:sample/helpers/data_lists.dart';

class Docs extends ChangeNotifier {
  Map _data = {};
  List<Doc> doctors = [];
  List<Doc> searchedDoctors = [];
  bool clicked = true;
  Future<void> refresh(
    Function fun,
    BuildContext context,
    Function(List<Map>) setCurrentDoctors,
    Account account,
  ) async {
    if (clicked) {
      final database = FirebaseDatabase.instance;
      doctors = [];
      print('first inside the function');
      DataSnapshot? dataSnap;
      try {
        clicked = !clicked;
        print('trying to get database');
        dataSnap = await database.ref().child("doctors").get();
        clicked = !clicked;
        print(doctors);
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
      print(doctors);
      print('got out ');
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
                    'classification': e.classification,
                  })
              .toList(),
        );
      }
    }
  }

  void search(String searchFor, String? byname) {
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
