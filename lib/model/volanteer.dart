import 'package:flutter/cupertino.dart';
import 'package:sample/model/role_provider.dart';
import 'package:sample/model/screens_spiprit_handle.dart';
import 'package:sample/model/user.dart';

class Volanteer {
  Volanteer() {}
  Volanteer.withCurrentUser(UserData currentUser) {
    name = currentUser.name;
    id = currentUser.id;
    phone = currentUser.phoneNumber;
    email = currentUser.email;
    team = currentUser.team;
    accepted = currentUser.accepted;
    state = currentUser.state;
    role = roleProvider.role;
    classification = currentUser.classification;
  }
  String? name;
  String? phone;
  String? id;
  String? email;
  String? team;
  List<Map>? patients;
  bool? accepted;
  String? state;
  ScreensTypes? role;
  String? classification;
}
