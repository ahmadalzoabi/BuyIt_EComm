import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../extensions.dart';
import '../widgets/logo.dart';
import '../services/auth.dart';
import '../widgets/TextField.dart';
import '../providers/modelHud.dart';
import '../screens/logIn_Screen.dart';
import '../screens/user/Home_Screen.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/SignUpScreen';
  GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    final  modelHud = Provider.of<ModelHud>(context);
    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: modelHud.isLoading,
          child: Form(
            key: _signUpKey,
            child: ListView(children: [
              LogoWidget(),
              CustomTextField(
                hintText: 'Eenter your Name',
                prefixIcon: Icons.person,
                type: 'Name',
              ),
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
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.all(12),
                    shape: StadiumBorder(),
                  ),
                  onPressed: () async {
                    if (_signUpKey.currentState!.validate()) {
                      modelHud.changeIsLoading(true);
                      _signUpKey.currentState!.save();
                      UserCredential userCredential = await (Auth().signUp(
                        email: email,
                        password: password,
                        ctx: context,
                        modelHud: modelHud
                      ));
                      if (userCredential != null) {
                        modelHud.changeIsLoading(false);
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routeName);
                      } else {
                        modelHud.changeIsLoading(false);
                      }
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(LogInScreen.routeName);
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Already have an Account ? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign IN',
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
