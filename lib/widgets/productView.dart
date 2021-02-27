import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/gridItem.dart';
import '../screens/user/productInfo.dart';

Widget productView(Stream store) {
  return StreamBuilder<List<Product>>(
    stream: store,
    builder: (BuildContext context, AsyncSnapshot<List<Product>> snapShot) {
      if (snapShot.hasData) {
        return GridView.builder(
          padding: const EdgeInsets.all(4.0),
          itemCount: snapShot.data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductInfo.routeName,
                  arguments: snapShot.data[index]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridItem(
                image: snapShot.data[index].pLocation,
                name: snapShot.data[index].pName,
                price: snapShot.data[index].pPrice,
                cart: () {
                  // Navigator.of(context).pushNamed(ProductInfo.routeName,
                  //     arguments: snapShot.data[index]);
                },
              ),
            ),
          ),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
