import 'package:flutter/material.dart';

class AdminMode with ChangeNotifier {
  
  bool isAdmin = false;
  changeIsAdmin(bool value) {
    isAdmin = value;
    notifyListeners();
  }
}
