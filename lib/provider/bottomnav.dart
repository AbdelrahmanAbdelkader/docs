import 'package:flutter/material.dart';
import 'package:sample/helpers/docicon.dart';
import 'package:sample/screens/docscreen/doc_page.dart';
import 'package:sample/screens/patientscreen/patientScreen.dart';
import 'package:sample/screens/volscreen/volscreen.dart';
import 'package:sample/screens/volscreen/widgets/volprofile/volprofilescreen.dart';

class BottomNav extends ChangeNotifier {
  Map<String, Map> types = {};
  int current = 0;
  List<Map> bottomNavBarItems = [{}];
  String role = '';
  void set(int ne) {
    current = ne;
    notifyListeners();
  }

  void setRole(String r) {
    // print(r);
    role = r;
    if (r == 'متطوع غني') {
      bottomNavBarItems = [
        {
          'icon': DocIcons.doctor,
          'label': 'الدكاترة',
          'screen': DocList(),
        },
        {
          'icon': Icons.notes,
          'label': 'أبحاث',
          'screen': PatientScreen(),
        },
        {
          'icon': Icons.person,
          'label': 'المتطوعين',
          'screen': VolScreen(),
        },
        // {
        //   'icon': Icons.account_circle_outlined,
        //   'label': 'الأكونت',
        //   'screen': VolanteerProfileScreen(),
        // },
      ];
    } else if (r == 'متطوع فقير') {
      bottomNavBarItems = [
        {
          'icon': Icons.notes,
          'label': 'أبحاث',
          'screen': PatientScreen(),
        },
        {
          'icon': Icons.account_circle_outlined,
          'label': 'الأكونت',
          'screen': VolanteerProfileScreen(),
        },
      ];
    } else if (r == 'مسؤول أبحاث') {
      bottomNavBarItems = [
        {
          'icon': Icons.notes,
          'label': 'أبحاث',
          'screen': PatientScreen(),
        },
        {
          'icon': Icons.account_circle_outlined,
          'label': 'الأكونت',
          'screen': VolanteerProfileScreen(),
        },
      ];
    } else if (r == 'مسؤول دكاترة') {
      bottomNavBarItems = [
        {
          'icon': DocIcons.doctor,
          'label': 'الدكاترة',
          'screen': DocList(),
        },
        {
          'icon': Icons.notes,
          'label': 'أبحاث',
          'screen': PatientScreen(),
        },
        {
          'icon': Icons.account_circle_outlined,
          'label': 'الأكونت',
          'screen': VolanteerProfileScreen(),
        },
      ];
    }
    print(role);
    print(bottomNavBarItems);
  }
}
