import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';
import '../models/order.dart';
import '../models/product.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // add product to fireBase
  addProduct(Product product) {
    _firestore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductDescription: product.pDescription,
      kProductLocation: product.pLocation,
      kProductCategory: product.pCategory,
      kProductPrice: product.pPrice
    });
  }

  // map shanshote to list of products
  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data()!;
      return Product(
        pId: doc.id,
        pName: data[kProductName],
        pCategory: data[kProductCategory],
        pPrice: data[kProductPrice],
        pDescription: data[kProductDescription],
        pLocation: data[kProductLocation],
      );
    }).toList();
  }

  // load all products from fireBase by stream
  Stream<List<Product>> loadProducts() {
    return _firestore
        .collection(kProductsCollection)
        .orderBy(kProductName, descending: false)
        .snapshots()
        .map(_productListFromSnapshot);
  }

  // load all Jacket from fireBase by stream
  Stream<List<Product>> loadJacketProducts() {
    return _firestore
        .collection(kProductsCollection)
        .orderBy(kProductCategory, descending: false)
        .startAt([kJackets])
        .endAt([kJackets])
        .snapshots()
        .map(_productListFromSnapshot);
  }

  // load all Trousers from fireBase by stream
  Stream<List<Product>> loadTrousersProducts() {
    return _firestore
        .collection(kProductsCollection)
        .orderBy(kProductCategory, descending: false)
        .startAt([kTrousers])
        .endAt([kTrousers])
        .snapshots()
        .map(_productListFromSnapshot);
  }

  // load all T-shirts from fireBase by stream
  Stream<List<Product>> loadTshirtsProducts() {
    return _firestore
        .collection(kProductsCollection)
        .orderBy(kProductCategory, descending: false)
        .startAt([kTshirts])
        .endAt([kTshirts])
        .snapshots()
        .map(_productListFromSnapshot);
  }

  // load all Shoes from fireBase by stream
  Stream<List<Product>> loadShoesProducts() {
    return _firestore
        .collection(kProductsCollection)
        .orderBy(kProductCategory, descending: false)
        .startAt([kShoes])
        .endAt([kShoes])
        .snapshots()
        .map(_productListFromSnapshot);
  }

  // delete product from fireBase
  deleteProduct({documentId}) {
    _firestore.collection(kProductsCollection).doc(documentId).delete();
  }

  // edit product in fireBase
  editProduct({required data, documentId}) {
    _firestore.collection(kProductsCollection).doc(documentId).update(data);
  }

  // store the order in firebase
  storeOrders(data, List<Product> products) {
    DocumentReference documentRef = _firestore.collection(kOrders).doc();
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection(kOrderDetails).doc().set({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductQuantity: product.pQuantity,
        kProductLocation: product.pLocation,
        kProductCategory: product.pCategory
      });
    }
  }

//  anther method for store the order in firebase *** dont work with stream
  // storeOrders(double price, String? address, List<Product> products) {
  //   _firestore.collection(kOrders).add({
  //     kTotallPrice: price,
  //     kAddress: address,
  //     kOrderTime: DateTime.now(),
  //     kOrderDetails: products
  //         .map((product) => {
  //               kProductName: product.pName,
  //               kProductPrice: product.pPrice,
  //               kProductQuantity: product.pQuantity,
  //               kProductLocation: product.pLocation,
  //               kProductCategory: product.pCategory
  //             })
  //         .toList(),
  //   });
  // }

  // map shanshote to list of order Detalis
  List<Order> _ordersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data()!;
      print(data);
      return Order(
        documentId: doc.id,
        totallPrice: data[kTotallPrice],
        address: data[kAddress],
        createdAt: data[kOrderTime].toDate(),
      );
    }).toList();
  }

  // load all orders from fireBase
  Stream<List<Order>> loadOrders() {
    return _firestore
        .collection(kOrders)
        .snapshots()
        .map(_ordersListFromSnapshot);
  }

  // map shanshote to list of order Detalis
  List<Product> _orderDetalisListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data()!;
      return Product(
        pId: doc.id,
        pName: data[kProductName],
        pCategory: data[kProductCategory],
        pPrice: data[kProductPrice],
        pDescription: data[kProductDescription],
        pLocation: data[kProductLocation],
      );
    }).toList();
  }

  // load  order Detalis from fireBase
  Stream<List<Product>> loadOrdersDetalis(documentId){
    return _firestore
        .collection(kOrders)
        .doc(documentId) 
        .collection(kOrderDetails)
        .snapshots()
        .map(_orderDetalisListFromSnapshot);
  }
}
