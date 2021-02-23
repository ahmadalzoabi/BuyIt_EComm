import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import '../extensions.dart';
import '../widgets/logo.dart';
import '../services/auth.dart';
import '../widgets/TextField.dart';
import '../providers/modelHud.dart';
import '../screens/Home_Screen.dart';
import '../screens/SignUp_Screen.dart';

class LogInPage extends StatelessWidget {
   static const String routeName = '/LogIn';
   GlobalKey<FormState> _signInKey = GlobalKey<FormState>();
   String email;
   String password;

  @override
  Widget build(BuildContext context) {
    final modelHud = Provider.of<ModelHud>(context);
    return Scaffold(
      backgroundColor: KMainColor,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: modelHud.isLoading,
          child: Form(
            key: _signInKey,
            child: ListView(children: [
              LogoWidget(),
              CustomTextField(
                hintText: 'Eenter your email',
                prefixIcon: Icons.email,
                onSaved: (value) {
                  email = value;
                },
                type: 'Email',
              ),
              CustomTextField(
                hintText: 'Eenter your password',
                prefixIcon: Icons.lock,
                onSaved: (value) {
                  password = value;
                },
                type: 'Password',
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.3, vertical: 15),
                child: Builder(
                  builder: (ctx) => FlatButton(
                    padding: EdgeInsets.all(12),
                    shape: StadiumBorder(),
                    onPressed: () async {
                      if (_signInKey.currentState.validate()) {
                         modelHud.changeIsLoading(true);
                        _signInKey.currentState.save();
                        UserCredential userCredential = await Auth().logIn(email: email, password: password, ctx: ctx);
                        if (userCredential != null) {
                         modelHud.changeIsLoading(false);
                         Navigator.of(context).pushReplacementNamed(HomePage.routeName);
                        }
                        else{
                          modelHud.changeIsLoading(false);
                        }
                      }
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                  ),
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
      ),
    );
  }
}
