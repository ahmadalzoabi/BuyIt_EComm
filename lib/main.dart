import 'package:flutter/material.dart';

import './screens/home.dart';

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
        initialRoute: LogInPage.routeName,
        routes: <String, WidgetBuilder>{
          LogInPage.routeName: (context) => LogInPage(), // default routes or main route
        });
  }
}
