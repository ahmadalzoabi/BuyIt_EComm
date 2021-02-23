import 'package:flutter/material.dart';

class ModelHud with ChangeNotifier {
  bool isLoading = false;

  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
