import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';
import '../models/product.dart';

class Store {
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection(kProductsCollection);

  // add product to fireBase
  addProduct(Product product) {
    _firestore.add({
      kProductName: product.pName,
      kProductDescription: product.pDescription,
      kProductLocation: product.pLocation,
      kProductCategory: product.pCategory,
      kProductPrice: product.pPrice
    });
  }

  // load all products 
  // map shanshote to list of products
  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
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
    return _firestore.orderBy(kProductName, descending: false).snapshots().map(_productListFromSnapshot);
  }
  // load all Jacket from fireBase by stream
  Stream<List<Product>> loadJacketProducts() {
    return _firestore.orderBy(kProductCategory, descending: false).startAt([kJackets]).endAt([kJackets]).snapshots().map(_productListFromSnapshot);
  }
  // load all Trousers from fireBase by stream
  Stream<List<Product>> loadTrousersProducts() {
    return _firestore.orderBy(kProductCategory, descending: false).startAt([kTrousers]).endAt([kTrousers]).snapshots().map(_productListFromSnapshot);
  }
  // load all T-shirts from fireBase by stream
  Stream<List<Product>> loadTshirtsProducts() {
    return _firestore.orderBy(kProductCategory, descending: false).startAt([kTshirts]).endAt([kTshirts]).snapshots().map(_productListFromSnapshot);
  }
  // load all Shoes from fireBase by stream
  Stream<List<Product>> loadShoesProducts() {
    return _firestore.orderBy(kProductCategory, descending: false).startAt([kShoes]).endAt([kShoes]).snapshots().map(_productListFromSnapshot);
  }


  // delete product from fireBase
  deleteProduct({documentId}) {
    _firestore.doc(documentId).delete();
  }

  // edit product in fireBase
  editProduct({data, documentId}) {
    _firestore.doc(documentId).update(data);
  }
}
