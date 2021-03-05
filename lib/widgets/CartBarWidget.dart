import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../extensions.dart';
import '../widgets/badge.dart';
import '../providers/CartItem.dart';
import '../screens/user/cartScreen.dart';

class CartBarWidget extends StatelessWidget {
  const CartBarWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartItem cartItem = Provider.of<CartItem>(context);
    return Material(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 32, 20, 0),
        child: Container(
          height: context.height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Discover'.toUpperCase(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                     Navigator.pushNamed(context, CartScreen.routeName);
                },
                child: Badge(
                  color: Colors.white,
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.blue,
                    size: 29,
                  ),
                  value: cartItem.itemCount.toString(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
