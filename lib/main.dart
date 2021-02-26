import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'user/Home_Screen.dart';
import 'admin/Admin_Screen.dart';
import './admin/addProduct.dart';
import './admin/EditProduct.dart';
import './providers/modelHud.dart';
import './admin/OrdersScreen.dart';
import './admin/ManageProduct.dart';
import './providers/adminMode.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (_) => ModelHud(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (_) => AdminMode(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Buy it',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: LogInScreen.routeName, // default routes or main route
          routes: <String, WidgetBuilder>{
            LogInScreen.routeName: (context) => LogInScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            AdminScreen.routeName: (context) => AdminScreen(),
            AddProduct.routeName: (context) => AddProduct(),
            EditProduct.routeName: (context) => EditProduct(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            ManageProduct.routeName: (context) => ManageProduct(),
          }),
    );
  }
}
