import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../extensions.dart';
import '../../models/product.dart';
import '../../providers/CartItem.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/CartScreen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    final cartItem = Provider.of<CartItem>(context);
    List<Product> items = cartItem.items;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          if (cartItem.items.isNotEmpty)
            Container(
              height: ScreenSize.safeBlockVerticalWithAppBar * 0.92,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: GestureDetector(
                      onTapUp: (TapUpDetails details) async {
                        cartItem.showCustomMenu(details, context, index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45.0),
                              bottomLeft: Radius.circular(45.0),
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          color: kSecondaryColor,
                        ),
                        height: ScreenSize.safeBlockVerticalWithAppBar * .15,
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: ScreenSize.safeBlockVerticalWithAppBar *
                                  .15 /
                                  2,
                              backgroundImage:
                                  AssetImage(items[index].pLocation!),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          items[index].pName!,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '\$ ${items[index].pPrice}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      '× ${items[index].pQuantity.toString()}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: cartItem.items.length,
              ),
            )
          else
            Container(
              height: ScreenSize.safeBlockVerticalWithAppBar * 0.92,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Cart is Empty ',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      TextSpan(
                        text: '😿',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(ScreenSize.screenWidth, ScreenSize.safeBlockVerticalWithAppBar * 0.08),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                primary: kMainColor,
                onPrimary: Colors.black),
            onPressed: () {
              cartItem.showCustomDialog(context);
            },
            child: Text(
              'Order'.toUpperCase(),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
