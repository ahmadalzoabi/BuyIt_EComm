import 'package:flutter/material.dart';

import '../constants.dart';
import '../extensions.dart';
import '../admin/addProduct.dart';
import '../admin/OrdersScreen.dart';
import '../admin/ManageProduct.dart';

class AdminScreen extends StatelessWidget {
  static const String routeName = '/AdminScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Admin Controller'),
        centerTitle: true,
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
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.routeName);
              },
              color: Colors.green,
              child: Text('Add Product', style: TextStyle(color: Colors.white)),
              shape: StadiumBorder(),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, ManageProduct.routeName);
              },
              child:
                  Text('Edit Product', style: TextStyle(color: Colors.white)),
              color: Colors.red,
              shape: StadiumBorder(),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, OrdersScreen.routeName);
              },
              shape: StadiumBorder(),
              color: Colors.blue,
              child: Text('View orders', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
