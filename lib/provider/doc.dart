import 'package:flutter/cupertino.dart';

class Doc extends ChangeNotifier {
  late Function ref;
  String? Id;
  String phone = "";
  String hint = "";
  String name = "";
  String email = "";
  String classification = '';
  bool agreed = false;
  List<Map> patients = [];
  bool value = true;
  bool triedToValidate = false;
  String? val;

  void setCommuicate(bool s) {
    value = s;
    notifyListeners();
  }

  setTruedToValidate(bool val) {
    triedToValidate = val;
    notifyListeners();
  }

  void initData(Map data) {
    if (data['phone'] != null) phone = data['phone'];
    if (data['hint'] != null) hint = data['hint'];
    if (data['name'] != null) name = data['name'];
    if (data['agreed'] != null) agreed = data['agreed'];
    if (data['email'] != null) email = data['email'];
    if (data['classification'] != null) classification = data['classification'];
    if (data['petients'] != null)
      patients = (data['petients'] as Map).values.toList() as List<Map>;
    //  database.ref().child('doctors').child(id).get().then((v) {
    //   toAdd = v.value as Map<String, Object>;
    //   agreed = toAdd['agreed'] as bool;
    //   patients = [...toAdd['patients'] as List];
    //   val = toAdd['type'] as String;
    // });
  }

  void getTextFields(
      TextEditingController docNameController,
      TextEditingController docPhoneController,
      TextEditingController docEmailController,
      TextEditingController hintController) {
    docNameController.text = name;
    docPhoneController.text = phone;
    docEmailController.text = email;
    hintController.text = hint;
  }

  void toggle() {
    agreed = !agreed;
    notifyListeners();
  }

  setUserClassificationDropDownBottonValue(String val) {
    classification = val;
    notifyListeners();
  }
}
