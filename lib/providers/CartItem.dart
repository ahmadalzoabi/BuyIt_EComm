import 'package:flutter/material.dart';

import '../models/product.dart';

class CartItem with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((cartItem) {
      total += double.parse(cartItem.pPrice) * cartItem.pQuantity;
    });
    return total;
  }

// Inside Product Info Page
  addProduct(BuildContext context, Product product, int _quantity) {
    bool exist = false;
    for (var productInCart in _items) {
      if ((productInCart.pName == product.pName) && (productInCart.pQuantity != _quantity)) {
        exist = true;
        deleteProduct(productInCart);
        product.pQuantity = _quantity;
        _items.add(product);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('you\'ve repalced this product Quantity',
              textAlign: TextAlign.center),
        ));
        notifyListeners();
        return;
      }
      if ((productInCart.pName == product.pName) && (productInCart.pQuantity == _quantity)) {
        exist = true;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('you\'ve added this Quantity before',
              textAlign: TextAlign.center),
        ));
      }
    }
    if (!exist) {
      product.pQuantity = _quantity;
      _items.add(product);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'Added to Cart',
          textAlign: TextAlign.center,
        ),
      ));
      notifyListeners();
    }
  }

  deleteProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }

// Outside Product Info Page
  void addItem(Product product, context) {
    if (_items.contains(product)) {
      // change quantity...
      final index = _items.indexOf(product);
      Product pro = _items.elementAt(index);
      pro.pQuantity++;
      _items.removeAt(index);
      _items.insert(index, pro);
    } else {
      // add quantity...
      product.pQuantity = 1;
      _items.add(product);
    }
    notifyListeners();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        'Added to Cart',
        textAlign: TextAlign.center,
      ),
    ));
  }
}
