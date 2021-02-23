import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final String type;
  final Function onSaved;

  const CustomTextField(
      {Key key,
      @required this.hintText,
      @required this.prefixIcon,
      this.onSaved,
      @required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
      child: TextFormField(
        obscureText: type == 'Password' ? true : false,
        validator: (val) {
          switch (type) {
            case 'Name':
              {
                if (val.trim().isEmpty)
                  return '$type is empty';
                else if (val.trim().length > 15)
                  return 'value is too Long';
                else if (!regExpName.hasMatch(val))
                  return '$type is not correct';
              }
              break;
            case 'Email':
              {
                if (val.trim().isEmpty)
                  return '$type is empty';
                else if (!regExpEmail.hasMatch(val))
                  return '$type is not correct';
              }
              break;
            case 'Password':
              {
                if (val.trim().isEmpty)
                  return '$type is empty';
                else if (!regExpPass.hasMatch(val))
                  return '$type is not correct';
              }
              break;
          }
          return null;
        },
        cursorColor: KMainColor,
        onSaved: onSaved,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: KMainColor,
          ),
          fillColor: KFieldColor,
          filled: true,
          hintText: hintText,
          contentPadding: EdgeInsets.all(18),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Colors.blue, style: BorderStyle.solid, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}
