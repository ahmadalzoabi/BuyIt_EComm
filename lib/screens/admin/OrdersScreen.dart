import 'package:flutter/material.dart';

import '../../extensions.dart';
import '../../models/order.dart';
import '../../services/store.dart';
import '../admin/order_details.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/OrdersScreen';
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('ORDERS'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Order>>(
        stream: _store.loadOrders(),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OrderDetails.routeName,
                        arguments: snapshot.data![index].documentId);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54.withOpacity(0.8),
                      border: Border.all(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    height: ScreenSize.safeBlockVerticalWithAppBar * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              'Totall Price = \$${snapshot.data![index].totallPrice}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Address is ${snapshot.data![index].address}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
