import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../extensions.dart';
import '../../models/product.dart';
import '../../providers/CartItem.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/CartScreen';
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    final cartItem = Provider.of<CartItem>(context).items;

    return Scaffold(
      body: ListView.builder(
        itemCount: cartItem.length,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            leading: Text(cartItem[index].pName),
            title: Text(cartItem[index].pPrice),
            subtitle: Text(cartItem[index].pQuantity.toString()),
          );
        },
      ),
    );
  }
}
