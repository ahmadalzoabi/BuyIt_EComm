import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../extensions.dart';
import '../../services/store.dart';
import '../admin/EditProduct.dart';
import '../../models/product.dart';
import '../../widgets/gridItem.dart';
import '../../widgets/popUpMenuTap.dart';

class ManageProduct extends StatefulWidget {
  static const String routeName = '/ManageProduct';

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('MANAGE'),
        centerTitle: true,
      ),
      backgroundColor: kMainColor,
      body: StreamBuilder<List<Product>>(
        stream: _store.loadProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapShot) {
          if (snapShot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.all(4.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapShot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTapUp: (TapUpDetails details) async {
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
                              Navigator.of(context).pushNamed(
                                  EditProduct.routeName,
                                  arguments: snapShot.data![index]);
                            },
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          MyPopupMenuItem(
                            onClick: () {
                              _store.deleteProduct(
                                  documentId: snapShot.data![index].pId);
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GridItem(
                      image: snapShot.data![index].pLocation,
                      name: snapShot.data![index].pName,
                      price: null,
                      delete: () {
                        _store.deleteProduct(
                            documentId: snapShot.data![index].pId);
                      },
                      edit: () {
                        Navigator.of(context).pushNamed(EditProduct.routeName,
                            arguments: snapShot.data![index]);
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
