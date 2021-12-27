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
  }

  String? patientIllnessTypeDropDownButtonValue;
  setPatientIllnessTypeDropDownButtonValue(String v) {
    patientIllnessTypeDropDownButtonValue = v;
  }

  String? patientSelectedDoctorDropDownButtonValue;
  setpatientSelectedDoctorDropDownButtonValue(String v) {
    patientVillageDropDownButtonValue = v;
  }

  bool signIn = true;
  changeSigning() {
    signIn = !signIn;
    notifyListeners();
  }
  bool triedToValidate=false;
  toggleTriedToValidate(){
    triedToValidate=true;
    notifyListeners();
  }
}
