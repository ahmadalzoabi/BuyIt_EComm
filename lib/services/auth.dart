import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/modelHud.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

// sign Up to firebase
  Future signUp({required String email, required String password, BuildContext? ctx, required ModelHud modelHud }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return userCredential;
    } on FirebaseAuthException catch (err) {
      String? message = 'An error occurred, pelase check your credentials!';
      if (err.message != null) {
        message = err.message;
      }
      modelHud.changeIsLoading(false);
      print(message);
      ScaffoldMessenger.of(ctx!).showSnackBar(
        SnackBar(
          content: Text(message!, textAlign: TextAlign.center),
          backgroundColor: Colors.black,
        ),
      );
    } catch (err) {
      print(err); 
      String? message = 'An error occurred, pelase check your credentials!';
      modelHud.changeIsLoading(false);
     ScaffoldMessenger.of(ctx!).showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black,
        ),
      );
    }
  }

// log in to firebase
  Future logIn({required String email, required String password, BuildContext? ctx,required ModelHud modelHud }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return userCredential;
    } on FirebaseAuthException catch (err) {
      String? message = 'An error occurred, pelase check your credentials!';
      if (err.message != null) {
        message = err.message;
      }
      print(message);
      modelHud.changeIsLoading(false);
     ScaffoldMessenger.of(ctx!).showSnackBar(
        SnackBar(
          content: Text(message!, textAlign: TextAlign.center),
          backgroundColor: Colors.black,
        ),
      );
    } catch (err) {
      String? message = 'An error occurred, pelase check your credentials!';
      print(message);
      modelHud.changeIsLoading(false);
     ScaffoldMessenger.of(ctx!).showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black,
        ),
      );
    }
  }
}
