import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

// sign Up to firebase
  Future signUp({String email, String password, BuildContext ctx}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(userCredential);
      return userCredential;
    } on FirebaseAuthException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';
      if (err.message != null) {
        message = err.message;
      }
      print(message);
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message, textAlign: TextAlign.center),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (err) {
      print(err);
      var message = err.message;
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }
  }

// log in to firebase
  Future logIn({String email, String password, BuildContext ctx}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';
      if (err.message != null) {
        message = err.message;
      }
      print(message);
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message, textAlign: TextAlign.center),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (err) {
      var message = err.message;
      print(message);
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }
  }
}
