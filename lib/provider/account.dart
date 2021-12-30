import 'package:flutter/material.dart';
import 'package:sample/helpers/docicon.dart';
import 'package:sample/provider/volanteer.dart';
import 'package:sample/screens/docscreen/doc_page.dart';
import 'package:sample/screens/docscreen/getDoctorsData.dart';
import 'package:sample/screens/patientscreen/patientScreen.dart';
import 'package:sample/screens/volscreen/volscreen.dart';
import 'package:sample/screens/volscreen/widgets/volprofile/volprofilescreen.dart';

class Account extends ChangeNotifier {
  String? _id;
  String _role = '';
  bool? _accepted;
  String? _team;
  String? name;
  int current = 0;
  List<Map> bottomNavBarItems = [{}];

  String? get id => _id;
  String get role => _role;
  bool? get accepted => _accepted;
  String? get team => _team;
  void setName(String val) {
    name = val;
  }

  void printData() {
    print(_id);
    print(_role);
    print(_accepted);
    print(_team);
    print(name);
    print(current);
    print(bottomNavBarItems);
  }

  void setCurrent(int ne) {
    current = ne;
    if (ne == 0) {
      if (_role == 'متطوع غني' || _role == 'مسؤول دكاترة')
        bottomNavBarItems[current]['screen'] = GetDoctorsData();
      else
        bottomNavBarItems[current]['screen'] = PatientScreen();
    } else if (ne == 1) {
      if (_role == 'متطوع غني' || _role == 'مسؤول دكاترة')
        bottomNavBarItems[current]['screen'] = PatientScreen();
      else
        bottomNavBarItems[current]['screen'] =
            VolanteerProfileScreen(Volanteer());
    } else if (ne == 2) {
      if (_role == 'مسؤول دكاترة')
        bottomNavBarItems[current]['screen'] =
            VolanteerProfileScreen(Volanteer());
      else {
        print('ss');
        bottomNavBarItems[current]['screen'] = VolScreen();
        print('bb');
      }
    } else if (ne == 3) {
      bottomNavBarItems[current]['screen'] =
          VolanteerProfileScreen(Volanteer());
    }

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
          'screen': GetDoctorsData(),
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
          'screen': VolanteerProfileScreen(Volanteer()),
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
          'screen': VolanteerProfileScreen(Volanteer()),
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
          'screen': VolanteerProfileScreen(Volanteer()),
        },
      ];
    } else if (r == 'مسؤول دكاترة') {
      bottomNavBarItems = [
        {
          'icon': DocIcons.doctor,
          'label': 'الدكاترة',
          'screen': GetDoctorsData(),
        },
        {
          'icon': Icons.notes,
          'label': 'أبحاث',
          'screen': PatientScreen(),
        },
        {
          'icon': Icons.account_circle_outlined,
          'label': 'الأكونت',
          'screen': VolanteerProfileScreen(Volanteer()),
        },
      ];
    }
  }
}
