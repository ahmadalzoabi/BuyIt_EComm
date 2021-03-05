import 'package:flutter/material.dart';

class AdminMode with ChangeNotifier {
  bool isAdmin = false;
  void changeIsAdmin(bool value) {
    isAdmin = value;
    notifyListeners();
  }
}
