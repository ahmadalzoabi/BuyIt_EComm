import 'package:flutter/material.dart';

// colors
const kMainColor = Color(0xffffc12f);
const kFieldColor = Color(0xffffe6fc);
const kUnActiveColor = Color(0xFFFFFFFF); 
const kSecondaryColor = Color(0xFFFFE6AC);


//validation for inputs logIn and signUp
Pattern patternEmail =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExpEmail = RegExp(patternEmail as String);
Pattern patternName = r'(^[a-zA-Z])';
RegExp regExpName = RegExp(patternName as String);
Pattern patternPass =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
RegExp regExpPass = RegExp(patternPass as String);


// admin auth
String adminPassword = 'admin1Buy*';
String adminEmail = 'admin@gmail.com';


// product properties
const kProductsCollection = 'Products';
const kProductName = 'Name';
const kProductDescription = 'Description';
const kProductLocation = 'Location';
const kProductCategory = 'Category';
const kProductPrice = 'Price';


// shop constant
const kJackets = 'jackets';
const kTrousers = 'trousers';
const kTshirts = 't-shirts';
const kShoes = 'shoes';
const kOrders = 'Orders';
const kOrderDetails = 'OrderDetails';
const kOrderTime = 'createdAt';
const kTotallPrice = 'TotallPrice';
const kAddress = 'Address';
const kProductQuantity = 'Quantity';



// user constant
const kKeepMeLoggedIn = 'KeepMeLoggedIn';
