import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './providers/modelHud.dart';
import './screens/Home_Screen.dart';
import './screens/logIn_Screen.dart';
import './screens/SignUp_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
          create:(_) => ModelHud() ,
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Buy it',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: LogInPage.routeName, // default routes or main route
          routes: <String, WidgetBuilder>{
            LogInPage.routeName: (context) => LogInPage(),
            SignUpPage.routeName: (context) => SignUpPage(),
            HomePage.routeName: (context) => HomePage(),
          }),
    );
  }
}
