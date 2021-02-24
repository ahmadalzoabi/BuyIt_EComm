import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import '../extensions.dart';
import '../widgets/logo.dart';
import '../services/auth.dart';
import '../user/Home_Screen.dart';
import '../widgets/TextField.dart';
import '../providers/modelHud.dart';
import '../admin/Admin_Screen.dart';
import '../providers/adminMode.dart';
import '../screens/SignUp_Screen.dart';

class LogInScreen extends StatelessWidget {
  static const String routeName = '/LogInScreen';

  GlobalKey<FormState> _signInKey = GlobalKey<FormState>();
  String email;
  String password;

  Future _validate(BuildContext ctx, BuildContext context, ModelHud modelHud,AdminMode adminMode) async {
    if (_signInKey.currentState.validate()) {
      modelHud.changeIsLoading(true);
      _signInKey.currentState.save();
      if (adminMode.isAdmin) {
        if (password == adminPassword && email == adminEmail) {
          UserCredential userCredential =
              await Auth().logIn(email: email, password: password, ctx: ctx);
          if (userCredential != null) {
            modelHud.changeIsLoading(false);
            Navigator.of(context).pushReplacementNamed(AdminScreen.routeName);
          } else {
            modelHud.changeIsLoading(false);
          }
        } else {
          modelHud.changeIsLoading(false);
          Scaffold.of(ctx).showSnackBar(
            SnackBar(
              content: Text('Something wrong in your email or password',
                  textAlign: TextAlign.center),
              backgroundColor: Colors.black,
            ),
          );
        }
      } else {
        UserCredential userCredential =
            await Auth().logIn(email: email, password: password, ctx: ctx);
        if (userCredential != null) {
          modelHud.changeIsLoading(false);
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } else {
          modelHud.changeIsLoading(false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final modelHud = Provider.of<ModelHud>(context);
    final adminMode = Provider.of<AdminMode>(context);
    return Scaffold(
      backgroundColor: kMainColor,
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
                      await _validate(ctx, context, modelHud, adminMode);
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
                    Navigator.of(context).pushNamed(SignUpScreen.routeName);
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.04,
                    vertical: context.height * 0.04),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          adminMode.changeIsAdmin(true);
                        },
                        child: Text(
                          'i\'m an admin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: adminMode.isAdmin
                                  ? kMainColor
                                  : Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          adminMode.changeIsAdmin(false);
                        },
                        child: Text(
                          'i\'m a user',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: adminMode.isAdmin
                                  ? Colors.white
                                  : kMainColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
