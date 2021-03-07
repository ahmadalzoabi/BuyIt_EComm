import 'package:flutter/material.dart';

// Extensions
extension ContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  bool get portrait => MediaQuery.of(this).orientation == Orientation.portrait;
  bool get landscape => MediaQuery.of(this).orientation == Orientation.landscape;
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
  static late double safeBlockHorizontal;
  static late double safeBlockVerticalWithAppBar;
  static late bool isPortrait;
  static late bool isLandscape;

  void init(BuildContext context) {
    screenHeight = context.height;
    screenWidth = context.width;
    safeAreaHorizontal = context.padding.left + context.padding.right;
    safeAreaVertical = context.padding.top + context.padding.bottom;
    safeBlockHorizontal = (screenWidth - safeAreaHorizontal);
    safeBlockVerticalWithAppBar =
        (screenHeight - safeAreaVertical - AppBar().preferredSize.height);
    isPortrait = context.portrait;
    isLandscape = context.landscape;
  }
}
