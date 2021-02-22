import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;

  const CustomTextField(
      {Key key, @required this.hintText, @required this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        cursorColor: KMainColor,
        decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              color: KMainColor,
            ),
            fillColor: KFieldColor,
            filled: true,
            hintText: hintText,
            contentPadding: EdgeInsets.all(18),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
