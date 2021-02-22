import 'package:flutter/material.dart';

import '../constants.dart';
import '../extensions.dart';
import '../widgets/TextField.dart';

class LogInPage extends StatefulWidget {
  static const String routeName = '/';

  LogInPage({Key key}) : super(key: key);
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMainColor,
      body: SafeArea(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 60),
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
          ),
          CustomTextField(
            hintText: 'Eenter your email',
            prefixIcon: Icons.email,
          ),
          CustomTextField(
            hintText: 'Eenter your password',
            prefixIcon: Icons.lock,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.width * 0.3, vertical: 20),
            child: FlatButton(
              padding: EdgeInsets.all(12),
              shape: StadiumBorder(),
              onPressed: () {},
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Pacifico',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Don\'t have an Account ? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: 'Sign In',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
