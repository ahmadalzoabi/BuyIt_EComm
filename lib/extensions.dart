import 'package:flutter/material.dart';

// Extensions
extension ContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  EdgeInsets get padding => MediaQuery.of(this).padding;
}

extension StringExtension on String {
  String get capitalize => "${this[0].toUpperCase()}${this.substring(1)}";
}

// .................

class ScreenSize {
  static late double screenHeight;
  static late double screenWidth;
  static late double safeAreaVertical;
  static late double safeAreaHorizontal;
  static double? safeBlockHorizontal;
  static late double safeBlockVerticalWithAppBar;

  void init(BuildContext context) {
    screenHeight = context.height;
    screenWidth = context.width;
    safeAreaHorizontal = context.padding.left + context.padding.right;
    safeAreaVertical = context.padding.top + context.padding.bottom;
    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) ;
    safeBlockVerticalWithAppBar =
        (screenHeight - safeAreaVertical - AppBar().preferredSize.height) ;
  }
}
