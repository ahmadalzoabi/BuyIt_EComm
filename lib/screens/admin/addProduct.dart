import 'package:buy_it/constants.dart';
import 'package:flutter/material.dart';

import '../../extensions.dart';
import '../../models/product.dart';
import '../../services/store.dart';
import '../../widgets/TextField.dart';

class AddProduct extends StatefulWidget {
  static const String routeName = '/AddProduct';

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _store = Store();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('ADD'),
        centerTitle: true,
      ),
      backgroundColor: kMainColor,
      // resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.green)),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: context.height * 0.13),
                      CustomTextField(
                        hintText: 'Product Name',
                        type: 'AdminAdd',
                        onSaved: (value) {
                          _name = value;
                        },
                      ),
                      CustomTextField(
                        type: 'AdminAdd',
                        onSaved: (value) {
                          _price = value;
                        },
                        hintText: 'Product Price',
                      ),
                      CustomTextField(
                        type: 'AdminAdd',
                        onSaved: (value) {
                          _description = value;
                        },
                        hintText: 'Product Description',
                      ),
                      CustomTextField(
                        type: 'AdminAdd',
                        onSaved: (value) {
                          _category = value;
                        },
                        hintText: 'Product Category',
                      ),
                      CustomTextField(
                        type: 'AdminAdd',
                        onSaved: (value) {
                          _imageLocation = value;
                        },
                        hintText: 'Product Location',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Builder(
                          builder: (ctx) => FlatButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 12),
                            shape: StadiumBorder(),
                            color: Colors.green,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                _formKey.currentState.save();
                                // _formKey.currentState.reset();
                                _store.addProduct(
                                  Product(
                                      pName: _name,
                                      pPrice: _price,
                                      pDescription: _description,
                                      pLocation: _imageLocation,
                                      pCategory: _category),
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                Scaffold.of(ctx).showSnackBar(
                                  SnackBar(
                                    content: Text('Data Added',
                                        textAlign: TextAlign.center),
                                    backgroundColor: Colors.black,
                                  ),
                                );
                              }
                            },
                            child: const Text('Add Product',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
