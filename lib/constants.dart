import 'package:flutter/material.dart';

const kMainColor = Color(0xffffc12f);
const kFieldColor = Color(0xffffe6fc);

Pattern patternEmail =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExpEmail = RegExp(patternEmail);
Pattern patternName = r'(^[a-zA-Z])';
RegExp regExpName = RegExp(patternName);
Pattern patternPass =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
RegExp regExpPass = RegExp(patternPass);

String adminPassword = 'admin1Buy*';
String adminEmail = 'admin@gmail.com';