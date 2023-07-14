import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slmc_app/intro/login.dart';
import 'package:slmc_app/intro_bloc/user_model.dart';
import 'package:slmc_app/product_block/ProductView.dart';

class Authentication {
  // For Authentication related functions you need an instance of FirebaseAuth
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //  This getter will be returning a Stream of User object.
  //  It will be used to check if the user is logged in or not.
  Stream<User?> get authStateChange => _auth.authStateChanges();
  // @override
  // Stream<UserModel> getCurrentUser() {
  //   return _auth.retrieveCurrentUser();
  // }

  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser;
    return currentUser != null;
  }
  // Now This Class Contains 3 Functions currently
  // 1. signInWithGoogle
  // 2. signOut
  // 3. signInwithEmailAndPassword

  //  All these functions are async because this involves a future.
  //  if async keyword is not used, it will throw an error.
  //  to know more about futures, check out the documentation.
  //  https://dart.dev/codelabs/async-await
  //  Read this to know more about futures.
  //  Trust me it will really clear all your concepts about futures

  //  SigIn the user using Email and Password
  bool isAuthenticated = false;

  // Stream<UserModel> retrieveCurrentUser() {
  //   return _auth.authStateChanges().map((User? user) {
  //     if (user != null) {
  //       return UserModel(uid: user.uid, email: user.email);
  //     } else {
  //       return  UserModel(uid: "uid");
  //     }
  //   });
  // }
  // SignUp the user using Email and Password
  Future<void> signUpWithEmailAndPassword(
      String email,String name, String password,String contact_number, BuildContext context) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("userid prining" + user.user!.uid);

      UserModel userModel = UserModel(
        email: email,
        name: name!,
        uid: user.user!.uid,
        contact_number: contact_number,
      );

      await _firestore.collection('users').doc(user.user!.uid).set(
        userModel.toJson(),
      );

      Navigator.pushNamed(context, LoginPage.route);
      print("done");
    } on FirebaseAuthException catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
              title: Text('Error Occured'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("OK"))
              ]));
    } catch (e) {
      if (e == 'email-already-in-use') {
        print('Email already in use.');
      } else {
        print('Error: $e');
      }
    }
  }

  Future<void> logInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("userid prining" + user.user!.uid);
      Navigator.pushNamed(context, ProductView.route);
      isAuthenticated == true;
      print("done");
    } on FirebaseAuthException catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
              title: Text('Error Occured'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("OK"))
              ]));
    } catch (e) {
      if (e == 'email-already-in-use') {
        print('Email already in use.');
      } else {
        print('Error: $e');
      }
    }
  }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
