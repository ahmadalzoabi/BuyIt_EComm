import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../extensions.dart';
import '../../services/store.dart';
import '../../models/product.dart';
import '../../widgets/TextField.dart';

class EditProduct extends StatefulWidget {
  static const String routeName = '/EditProduct';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String? _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    print(product.pId);
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('EDIT'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: context.height * 0.13),
            CustomTextField(
              onSaved: (value) {
                _name = value;
              },
              hintText: 'Product Name',
              initValue: product.pName,
              type: 'AdminEdit',
            ),
            CustomTextField(
              onSaved: (value) {
                _price = value;
              },
              hintText: 'Product Price',
              initValue: product.pPrice,
              type: 'AdminEdit',
            ),
            CustomTextField(
              onSaved: (value) {
                _description = value;
              },
              hintText: 'Product Description',
              initValue: product.pDescription,
              type: 'AdminEdit',
            ),
            CustomTextField(
              onSaved: (value) {
                _category = value;
              },
              hintText: 'Product Category',
              initValue: product.pCategory,
              type: 'AdminEdit',
            ),
            CustomTextField(
              onSaved: (value) {
                _imageLocation = value;
              },
              hintText: 'Product Location',
              initValue: product.pLocation,
              type: 'AdminEdit',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                  shape: StadiumBorder(),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    _formKey.currentState!.save();
                    _store.editProduct(data: {
                      kProductName: _name,
                      kProductLocation: _imageLocation,
                      kProductCategory: _category,
                      kProductDescription: _description,
                      kProductPrice: _price
                    }, documentId: product.pId);
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Data Edited', textAlign: TextAlign.center),
                        backgroundColor: Colors.black,
                      ),
                    );
                    Future.delayed(Duration(milliseconds: 1200), () {
                      Navigator.of(context).pop();
                    });
                  }
                },
                child: const Text('Edit Product',
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        )),
      ),
    );
  }
}
