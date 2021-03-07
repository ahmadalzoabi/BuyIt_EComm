import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../logIn_Screen.dart';
import '../../constants.dart';
import '../../extensions.dart';
import '../admin/addProduct.dart';
import '../admin/OrdersScreen.dart';
import '../admin/ManageProduct.dart';
import '../../services/dataCached.dart';

class AdminScreen extends StatelessWidget {
  static const String routeName = '/AdminScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Admin Controller'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async{
                DataCacheService.deleteData();
                await FirebaseAuth.instance.signOut();
                Navigator.popAndPushNamed(context, LogInScreen.routeName);
              })
        ],
      ),
      backgroundColor: kMainColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              width: context.width * 1,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: Colors.green,
                  onPrimary: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.routeName);
              },
              child: Text('Add Product', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ManageProduct.routeName);
              },
              child:
                  Text('Manage Product', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: Colors.red,
                  onPrimary: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, OrdersScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: Colors.blue,
                  onPrimary: Colors.white),
              child: Text('View orders', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
