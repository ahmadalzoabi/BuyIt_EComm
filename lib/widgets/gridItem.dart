import 'package:flutter/material.dart';

import '../extensions.dart';

class GridItem extends StatelessWidget {
  final String? image;
  final String? name;
  final String? price;
  final Function? edit;
  final Function? delete;
  final Function? add;
  const GridItem(
      {Key? key, this.image, this.name, this.price, this.delete, this.edit, this.add})
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
                    onPressed: edit as void Function()?,
                  ),
                  IconButton(
                    tooltip: 'delete',
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed: delete as void Function()?,
                  ),
                ],
              )
            : IconButton(
                    tooltip: 'add',
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.blue,
                      size: 20,
                    ),
                    onPressed: add as void Function()?,
                  ),
      ),
    );
  }
}
