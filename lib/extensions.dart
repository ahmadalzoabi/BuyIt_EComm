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
  static double screenHeight;
  static double screenWidth;
  static double safeAreaVertical;
  static double safeAreaHorizontal;
  static double safeBlockHorizontal;
  static double safeBlockVerticalWithAppBar;

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
