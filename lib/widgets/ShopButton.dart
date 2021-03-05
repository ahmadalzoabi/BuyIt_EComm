import 'package:flutter/material.dart';

import '../constants.dart';

class ShopButton extends StatelessWidget {
  final Function? onclick;
  final IconData? icon;
  const ShopButton({Key? key, this.icon, this.onclick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: kMainColor,
        child: GestureDetector(
          onTap: onclick as void Function()?,
          child: SizedBox(
            child: Icon(icon),
            height: 29,
            width: 29,
          ),
        ),
      ),
    );
  }
}
