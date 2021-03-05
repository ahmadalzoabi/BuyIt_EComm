import '../models/product.dart';

class Order {
  String? documentId;
  double? totallPrice;
  String? address;
  DateTime? createdAt;
  List<Product>? products;
  Order({this.totallPrice, this.address, this.documentId,this.createdAt,this.products});
}
