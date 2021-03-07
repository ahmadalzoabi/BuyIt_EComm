import 'package:buy_it/extensions.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../services/store.dart';
import '../../models/product.dart';

class OrderDetails extends StatelessWidget {
  static const String routeName = '/OrderDetailes';

  final Store store = Store();

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    String documentId = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('ORDER DETAILES'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Product>>(
          stream: store.loadOrdersDetalis(documentId),
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black54.withOpacity(0.8),
                            border: Border.all(color: Colors.red, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          height: ScreenSize.safeBlockVerticalWithAppBar * 0.28,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    'product name : ${snapshot.data![index].pName}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Quantity : ${snapshot.data![index].pQuantity}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'product Price : ${snapshot.data![index].pPrice}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'product Category : ${snapshot.data![index].pCategory}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: snapshot.data!.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: kMainColor,
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                shape: StadiumBorder(),
                              ),
                              onPressed: () {},
                              child: Text('Confirm Order'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: kMainColor,
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                shape: StadiumBorder(),
                              ),
                              onPressed: () {},
                              child: Text('Delete Order'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
