import 'package:flutter/material.dart';

class StateManagment extends ChangeNotifier {
  String? userTeamDropDownBottonValue;
  setUserTeamDropDownBottonValue(String v) {
    userTeamDropDownBottonValue = v;
    notifyListeners();
  }

  String? userSpecialityDropDownBottonValue;
  setUserSpecialityDropDownButtonValue(String v) {
    userSpecialityDropDownBottonValue = v;
    notifyListeners();
  }

  String? roleDropDownBottonValue;
  setRoleDropDownBottonValue(String v) {
    roleDropDownBottonValue = v;
    notifyListeners();
  }

  String? doctorSearchDropDownButtonValue;
  setDoctorSearchDropDownButtonValue(String v) {
    doctorSearchDropDownButtonValue = v;
    notifyListeners();
  }

  String? patientVillageDropDownButtonValue;
  setPatientVillageDropDownButtonValue(String v) {
    patientVillageDropDownButtonValue = v;
    notifyListeners();
  }

  String? patientIllnessTypeDropDownButtonValue;
  setPatientIllnessTypeDropDownButtonValue(String v) {
    patientIllnessTypeDropDownButtonValue=v;
    notifyListeners();
  }

  bool signIn = true;
  changeSigning() {
    signIn = !signIn;
    notifyListeners();
  }
}
