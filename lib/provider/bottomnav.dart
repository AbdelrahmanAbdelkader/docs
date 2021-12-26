import 'package:flutter/material.dart';

class BottomNav extends ChangeNotifier {
  int current = 0;
  String role = '';
  void set(int ne) {
    current = ne;
    notifyListeners();
  }
}
