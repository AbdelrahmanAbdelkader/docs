import 'package:flutter/material.dart';
import 'package:sample/helpers/docicon.dart';
import 'package:sample/screens/docscreen/doc_page.dart';
import 'package:sample/screens/patientscreen/patientScreen.dart';
import 'package:sample/screens/volscreen/volscreen.dart';
import 'package:sample/screens/volscreen/widgets/volprofile/volprofilescreen.dart';

class Account extends ChangeNotifier {
  String? _id;
  String _role = '';
  bool? _accepted;
  String? _team;
  Map<String, Map> types = {};
  int current = 0;
  List<Map> bottomNavBarItems = [{}];

  String? get id => _id;
  String get role => _role;
  bool? get accepted => _accepted;
  String? get team => _team;
  void setCurrent(int ne) {
    current = ne;
    notifyListeners();
  }

  void setTeam(String team) {
    _team = team;
  }

  void setId(String id) {
    _id = id;
  }

  void setAccepted(bool accepted) {
    _accepted = accepted;
  }

  void setRole(String r) {
    // print(r);
    _role = r;
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
        {
          'icon': Icons.person,
          'label': 'المتطوعين',
          'screen': VolanteerProfileScreen(),
        }
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
  }
}
