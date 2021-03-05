import 'package:flutter/material.dart';

import '../constants.dart';
import '../extensions.dart';
import '../models/product.dart';
import '../services/store.dart';
import '../widgets/popUpMenuTap.dart';
import '../screens/user/productInfo.dart';

class CartItem with ChangeNotifier {
  List<Product> _items = [];
  int number = 1;
  List<Product> get items {
    return [..._items];
  }

  // total Amount products in the cart
  int get itemCount {
    return _items.length;
  }

  // total Amount for the cart
  double get totalAmount {
    var total = 0.0;
    _items.forEach((cartItem) {
      total += double.parse(cartItem.pPrice!) * cartItem.pQuantity!;
    });
    return total;
  }


  // clear cart
  void clear() {
    _items.clear();
    notifyListeners();
  }


  // add product Inside Product Info Page
  addProduct(BuildContext context, Product product, int _quantity) {
    bool exist = false;
    for (var productInCart in _items) {
      if ((productInCart.pName == product.pName) &&
          (productInCart.pQuantity != _quantity)) {
        exist = true;
        deleteProduct(productInCart);
        product.pQuantity = _quantity;
        _items.add(product);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('you\'ve repalced this product Quantity',
              textAlign: TextAlign.center),
        ));
        notifyListeners();
        return;
      }
      if ((productInCart.pName == product.pName) &&
          (productInCart.pQuantity == _quantity)) {
        exist = true;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('you\'ve added this Quantity before',
              textAlign: TextAlign.center),
        ));
      }
    }
    if (!exist) {
      product.pQuantity = _quantity;
      _items.add(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Added to Cart',
          textAlign: TextAlign.center,
        ),
      ));
      notifyListeners();
    }
  }

  // delete product
  deleteProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  // add product Outside Product Info Page
  void addItem(Product product, context) {
    if (_items.contains(product)) {
      // change quantity...
      number ++;
      final index = _items.indexOf(product);
      Product pro = _items.elementAt(index);
      pro.pQuantity = number;
      _items.removeAt(index);
      _items.insert(index, pro);
    } else {
      // add quantity...
      product.pQuantity = 1;
      _items.add(product);
    }
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Added to Cart',
        textAlign: TextAlign.center,
      ),
    ));
  }

  // show Custom Menu
  void showCustomMenu(
      TapUpDetails details, BuildContext context, int index) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    await showMenu(
        color: Colors.black87.withOpacity(0.8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.red)),
        context: context,
        position: RelativeRect.fromLTRB(
            dx, dy, context.width - dx, context.height - dy),
        items: [
          MyPopupMenuItem(
            onClick: () {
              Navigator.of(context).pushReplacementNamed(ProductInfo.routeName,
                  arguments: _items[index]);
            },
            child: Text(
              'Info',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          MyPopupMenuItem(
            onClick: () {
              deleteProduct(_items[index]);
              notifyListeners();
            },
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ]);
  }

  // show Custom Dialog
  void showCustomDialog(context) async {
    double price = totalAmount;
    String? address;
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            if (address != null && address!.isNotEmpty && price > 0.0 ) {
              try {
                Store().storeOrders( {kTotallPrice: price, kAddress: address,kOrderTime: DateTime.now(),}, items);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Ordered Successfully done',textAlign: TextAlign.center,),
                ));
                Navigator.pop(context);
                clear();
              } catch (ex) {
                print(ex);
              }
            } else {
              return;
            }
          },
          child: Text('Confirm'),
        )
      ],
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(hintText: 'Enter your Address'),
      ),
      title: Text('Totall Price  = \$$price'),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
