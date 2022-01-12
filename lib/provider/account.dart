import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample/helpers/docicon.dart';
import 'package:sample/model/post.dart';
import 'package:sample/provider/volanteer.dart';
import 'package:sample/screens/docscreen/getDoctorsData.dart';
import 'package:sample/screens/patientscreen/patientScreen.dart';
import 'package:sample/screens/postscreen/getPostsScreen.dart';
import 'package:sample/screens/postscreen/posts_screen.dart';
import 'package:sample/screens/volscreen/volscreen.dart';
import 'package:sample/screens/volscreen/widgets/volprofile/volprofilescreen.dart';

class Account extends ChangeNotifier {
  String? _id;
  String _role = '';
  bool? _accepted;
  String? _team;
  String? name;
  int current = 0;
  List<Map> bottomNavBarItems = [];

  String? get id => _id;
  String get role => _role;
  bool? get accepted => _accepted;
  String? get team => _team;
  void setName(String val) {
    name = val;
  }

  // void printData() {
  //   print('acount data');
  //   print(_id);
  //   print(_role);
  //   print(_accepted);
  //   print(_team);
  //   print(name);
  //   print(current);
  //   print(bottomNavBarItems);
  // }

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
        bottomNavBarItems[current]['screen'] = GetPostsScreen();
    } else if (ne == 2) {
      if (_role == 'مسؤول دكاترة' || _role == 'متطوع غني')
        bottomNavBarItems[current]['screen'] = GetPostsScreen();
      else
        bottomNavBarItems[current]['screen'] =
            VolanteerProfileScreen(Volanteer());
    } else if (ne == 3) {
      if (_role == 'مسؤول دكاترة')
        bottomNavBarItems[current]['screen'] =
            VolanteerProfileScreen(Volanteer());
      else {
        bottomNavBarItems[current]['screen'] = VolScreen();
      }
    } else
      bottomNavBarItems[current]['screen'] =
          VolanteerProfileScreen(Volanteer());

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
    _role = r;
    bottomNavBarItems = [];
    if (r == 'متطوع غني' || r == 'مسؤول دكاترة')
      bottomNavBarItems.add({
        'icon': DocIcons.doctor,
        'label': 'الدكاترة',
        'screen': GetDoctorsData(),
      });
    bottomNavBarItems.add(
      {
        'icon': Icons.notes,
        'label': 'أبحاث',
        'screen': PatientScreen(),
      },
    );
    bottomNavBarItems.add(
      {
        'icon': Icons.card_giftcard,
        'label': 'البوستات',
        'screen': GetPostsScreen(),
      },
    );
    if (r == 'متطوع غني')
      bottomNavBarItems.add(
        {
          'icon': Icons.person,
          'label': 'المتطوعين',
          'screen': VolScreen(),
        },
      );
    bottomNavBarItems.add({
      'icon': Icons.person,
      'label': 'الأكونت',
      'screen': VolanteerProfileScreen(Volanteer()),
    });
  }

  void uploadPost({
    String? title,
    required PostType type,
    required DateTime deadLine,
    List<String>? votesItems,
  }) {
    final database = FirebaseFirestore.instance;
    if (type == PostType.VotingPost) {
      int i = 1;
      database.collection('posts').add({
        'type': 'vote',
        'title': title,
        'votesItems': Map.fromIterable(
          votesItems as List,
          key: (e) {
            return i;
          },
          value: (e) {
            i++;
            return e;
          },
        ),
        'deadLine': deadLine.toString(),
      });
    } else if (type == PostType.NormalPost) {
      database.collection('posts').add({
        'type': 'vote',
        'title': title,
        'deadLine': deadLine.toString(),
      });
    }
  }
}
