import 'package:flutter/material.dart';

import './screens/logIn_Screen.dart';
import './screens/SignUp_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Buy it',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: LogInPage.routeName, // default routes or main route
        routes: <String, WidgetBuilder>{
          LogInPage.routeName: (context) => LogInPage(),
          SignUpPage.routeName: (context) => SignUpPage(),
        });
  }
}
