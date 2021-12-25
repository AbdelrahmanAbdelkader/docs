import 'package:flutter/material.dart';

class StateManagment extends ChangeNotifier {
  String? userTeamDropDownBottonValue;
  void setUserTeamDropDownBottonValue(String v) {
    userTeamDropDownBottonValue = v;
    notifyListeners();
  }

  String? userSpecialityDropDownBottonValue;
  void setUserSpecialityDropDownButtonValue(String v) {
    userSpecialityDropDownBottonValue = v;
    notifyListeners();
  }

  String? roleDropDownBottonValue;
  void setRoleDropDownBottonValue(String v) {
    roleDropDownBottonValue = v;
    notifyListeners();
  }

  String? doctorSearchDropDownButtonValue;
  void setDoctorSearchDropDownButtonValue(String v) {
    doctorSearchDropDownButtonValue = v;
    notifyListeners();
  }

  bool signIn = true;
  void changeSigning() {
    signIn = !signIn;
    notifyListeners();
  }
}
