import 'package:flutter/material.dart';

// Extensions
extension ContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

extension StringExtension on String {
    String get capitalize =>
       "${this[0].toUpperCase()}${this.substring(1)}";
   
}