import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './providers/CartItem.dart';
import './providers/modelHud.dart';
import './services/dataCached.dart';
import './providers/adminMode.dart';
import './screens/logIn_Screen.dart';
import './screens/SignUp_Screen.dart';
import './screens/user/cartScreen.dart';
import './screens/user/Home_Screen.dart';
import './screens/user/productInfo.dart';
import './screens/admin/addProduct.dart';
import './screens/admin/EditProduct.dart';
import './screens/admin/OrdersScreen.dart';
import './screens/admin/Admin_Screen.dart';
import './screens/admin/order_details.dart';
import './screens/admin/ManageProduct.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool save = await DataCacheService.getIsUserLoggedIn();
  bool admin = await DataCacheService.getIsUserAdmin();

  runApp(MyApp(save: save, admin: admin));
}

class MyApp extends StatelessWidget {
  MyApp({this.save, this.admin});
  final bool? save;
  final bool? admin;
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
          ),
          ChangeNotifierProvider<CartItem>(
            create: (_) => CartItem(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Buy it',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: save == true
                ? (admin == false ? HomeScreen() : AdminScreen())
                : LogInScreen(), // default routes or main route
            routes: <String, WidgetBuilder>{
              LogInScreen.routeName: (context) => LogInScreen(),
              SignUpScreen.routeName: (context) => SignUpScreen(),
              HomeScreen.routeName: (context) => HomeScreen(),
              AdminScreen.routeName: (context) => AdminScreen(),
              AddProduct.routeName: (context) => AddProduct(),
              EditProduct.routeName: (context) => EditProduct(),
              OrdersScreen.routeName: (context) => OrdersScreen(),
              ManageProduct.routeName: (context) => ManageProduct(),
              ProductInfo.routeName: (context) => ProductInfo(),
              CartScreen.routeName: (context) => CartScreen(),
              OrderDetails.routeName: (context) => OrderDetails(),
            }));
  }
}
