import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../extensions.dart';
import '../widgets/logo.dart';
import '../services/auth.dart';
import '../widgets/TextField.dart';
import '../providers/modelHud.dart';
import '../services/dataCached.dart';
import '../providers/adminMode.dart';
import '../screens/SignUp_Screen.dart';
import '../screens/user/Home_Screen.dart';
import '../screens/admin/Admin_Screen.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = '/LogInScreen';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> _signInKey = GlobalKey<FormState>();

  String? email;
  bool keepMeLoggedIn = false;
  String? password;

  Future _validate(BuildContext context, ModelHud modelHud, AdminMode adminMode) async {
    if (_signInKey.currentState!.validate()) {
      modelHud.changeIsLoading(true);
      _signInKey.currentState!.save();
      if (adminMode.isAdmin) {
        if (password == adminPassword && email == adminEmail) {
          var userCredential = await (Auth().logIn(
              email: email!,
              password: password!,
              ctx: context,
              modelHud: modelHud));
          if (userCredential != null) {
            modelHud.changeIsLoading(false);
            if (keepMeLoggedIn == true) {
              DataCacheService.keepUserLoggedIn(keepMeLoggedIn);
            }
            Navigator.of(context).pushReplacementNamed(AdminScreen.routeName);
          }
        } else {
          modelHud.changeIsLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Something wrong in your email or password',
                  textAlign: TextAlign.center),
              backgroundColor: Colors.black,
            ),
          );
        }
      } else {
        var userCredential = await (Auth().logIn(
            email: email!,
            password: password!,
            ctx: context,
            modelHud: modelHud));
        if (userCredential != null) {
          modelHud.changeIsLoading(false);
          if (keepMeLoggedIn == true) {
            DataCacheService.keepUserLoggedIn(keepMeLoggedIn);
          }
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
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
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.all(12),
                    shape: StadiumBorder(),
                  ),
                  onPressed: () async {
                    await _validate(context, modelHud, adminMode);
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: kMainColor,
                        value: keepMeLoggedIn,
                        onChanged: (value) {
                          setState(() {
                            keepMeLoggedIn = value!;
                          });
                        },
                      ),
                    ),
                    Text(
                      'Remmeber Me ',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
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
                          text: 'Sign UP',
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
