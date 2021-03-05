import 'package:flutter/material.dart';

class ModelHud with ChangeNotifier {
  bool isLoading = false;

   changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
