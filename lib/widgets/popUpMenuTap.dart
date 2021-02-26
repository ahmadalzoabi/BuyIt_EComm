import 'package:flutter/material.dart';

import '../admin/addProduct.dart';
import '../admin/EditProduct.dart';

class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final T value;
  MyPopupMenuItem({@required this.child, @required this.value})
      : super(child: child, value: value);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
  @override
  void handleTap() {
    Navigator.pop<T>(context);
    widget.value == 'Edit'
        ? Navigator.pushNamed(context, AddProduct.routeName)
        : Navigator.pushNamed(context, EditProduct.routeName); // EXAMPLE
  }
}
