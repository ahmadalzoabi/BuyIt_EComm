import 'package:flutter/material.dart';

import '../extensions.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 50),
      child: Container(
        height: context.height * 0.22,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'images/icons/buyicon.png',
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 0,
              child: Text(
                'Buy It',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
