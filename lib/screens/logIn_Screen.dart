import 'package:flutter/material.dart';

import '../constants.dart';
import '../extensions.dart';
import '../widgets/logo.dart';
import '../widgets/TextField.dart';
import '../screens/SignUp_Screen.dart';

class LogInPage extends StatefulWidget {
  static const String routeName = '/LogIn';

  LogInPage({Key key}) : super(key: key);
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  GlobalKey<FormState> _signInKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMainColor,
      body: SafeArea(
        child: Form(
          key: _signInKey,
          child: ListView(children: [
            LogoWidget(),
            CustomTextField(
              hintText: 'Eenter your email',
              prefixIcon: Icons.email,
              type: 'Email',
            ),
            CustomTextField(
              hintText: 'Eenter your password',
              prefixIcon: Icons.lock,
              type: 'Password',
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.3, vertical: 15),
              child: FlatButton(
                padding: EdgeInsets.all(12),
                shape: StadiumBorder(),
                onPressed: () {
                  if(_signInKey.currentState.validate()){
                    Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text(
                  'Log In',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(SignUpPage.routeName);
                },
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
              ),
            )
          ]),
        ),
      ),
    );
  }
}
