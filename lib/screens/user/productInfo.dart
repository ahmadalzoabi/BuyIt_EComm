import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../extensions.dart';
import '../../models/product.dart';
import '../../widgets/ShopButton.dart';
import '../../providers/CartItem.dart';
import '../../screens/user/cartScreen.dart';

class ProductInfo extends StatefulWidget {
  static const String routeName = '/ProductInfo';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    ScreenSize().init(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('About Product'),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: ScreenSize.safeBlockVerticalWithAppBar * 0.6,
                  width: ScreenSize.safeBlockHorizontal,
                  child: Image.asset(
                    product.pLocation,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Container(
                    height: ScreenSize.safeBlockVerticalWithAppBar * 0.12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Chip(label: Icon(Icons.arrow_back_ios))),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, CartScreen.routeName);
                            },
                            child: Chip(
                                label: Icon(
                              Icons.shopping_cart,
                              color: Colors.blueAccent,
                            )))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Stack(children: [
              Container(
                height: ScreenSize.safeBlockVerticalWithAppBar * 0.4,
                width: ScreenSize.safeBlockHorizontal,
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white.withOpacity(0.7),
                      width: context.width,
                      height: ScreenSize.safeBlockVerticalWithAppBar * 0.32,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                'Name : ${product.pName.capitalize}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Wrap(
                              children: [
                                Text(
                                  'Description : ${product.pDescription.capitalize}',
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                'Price : \$${product.pPrice}',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ShopButton(
                                    icon: Icons.add,
                                    onclick: add,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      '$_quantity',
                                      style: TextStyle(fontSize: 45),
                                    ),
                                  ),
                                  ShopButton(
                                    icon: Icons.remove,
                                    onclick: subtract,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: ScreenSize.safeBlockHorizontal,
                      height: ScreenSize.safeBlockVerticalWithAppBar * 0.08,
                      child: Builder(
                        builder: (ctx) => Consumer<CartItem>(
                          builder: (context, cartItem, _) => RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                            color: kMainColor,
                            onPressed: () {
                              cartItem.addProduct(ctx, product, _quantity);
                            },
                            child: Text(
                              'Add to Cart'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
