import 'package:flutter/material.dart';

import '../extensions.dart';

class GridItem extends StatelessWidget {
  final String image;
  final String name;
  final Function edit;
  final Function delete;
  const GridItem({Key key, this.image, this.name, this.delete, this.edit})
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
        title: SizedBox(),
        leading: Text(
          '$name'.capitalize,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        trailing: Row(
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
        ),
      ),
    );
  }
}
