import 'package:flutter/material.dart';

import '../extensions.dart';

class GridItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final Function edit;
  final Function delete;
  final Function cart;
  const GridItem(
      {Key key, this.image, this.name, this.price, this.delete, this.edit, this.cart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.asset(
        '$image',
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        title: price == null ? SizedBox() : Text('$price\$' ,textAlign: TextAlign.center, style: TextStyle(color:Colors.red)),
        leading: Text(
          '$name'.capitalize,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        trailing: price == null
            ? Row(
                children: [
                  IconButton(
                    tooltip: 'edit',
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                      size: 20,
                    ),
                    onPressed: edit,
                  ),
                  IconButton(
                    tooltip: 'delete',
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed: delete,
                  ),
                ],
              )
            : IconButton(
                    tooltip: 'cart',
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.blue,
                      size: 20,
                    ),
                    onPressed: cart,
                  ),
      ),
    );
  }
}
