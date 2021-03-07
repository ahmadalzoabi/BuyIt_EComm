import 'package:flutter/material.dart';

import '../services/dataCached.dart';

class AdminMode with ChangeNotifier {
  bool isAdmin = false;
  void changeIsAdmin(bool value) async {
    isAdmin = value;
    if (value == true) {
      await DataCacheService.keepUserInAdminMode(value);
      print(value);
    }
    notifyListeners();
  }
}
