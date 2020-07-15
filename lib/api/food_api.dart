import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodlab/model/food.dart';
import 'package:foodlab/notifier/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodlab/model/user.dart';
import 'package:foodlab/notifier/food_notifier.dart';
import 'package:foodlab/screens/login_signup_page.dart';
import 'package:foodlab/screens/navigation_bar.dart';

//USER PART
login(User user, AuthNotifier authNotifier, BuildContext context) async {
  AuthResult authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error));

  if (authResult != null) {
    FirebaseUser firebaseUser = authResult.user;
    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return NavigationBarPage();
        }),
      );
    }
  }
}

signUp(User user, AuthNotifier authNotifier, BuildContext context) async {
  AuthResult authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: user.email.trim(), password: user.password)
      .catchError((error) => print(error));

  if (authResult != null) {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = user.displayName;
    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      await firebaseUser.updateProfile(updateInfo);
      await firebaseUser.reload();

      print("Sign Up: $firebaseUser");

      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      authNotifier.setUser(currentUser);
//      Firestore.instance.collection('users').document(user.uid)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return NavigationBarPage();
        }),
      );
    }
  }
}

signOut(AuthNotifier authNotifier, BuildContext context) async {
  await FirebaseAuth.instance.signOut();

  authNotifier.setUser(null);
  print('log out');
  Navigator.push(
    context,
    MaterialPageRoute(builder: (BuildContext context) {
      return LoginPage();
    }),
  );
}

initializeCurrentUser(AuthNotifier authNotifier, BuildContext context) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  if (firebaseUser != null) {
    authNotifier.setUser(firebaseUser);
  }
}

//FOOD PART
//getFoods(FoodNotifier foodNotifier) async {
//  QuerySnapshot snapshot =
//      await Firestore.instance.collection('foods').getDocuments();
//
//  List<Food> _foodList = [];
//
//  snapshot.documents.forEach((document) {
//    Food food = Food.fromMap(document.data);
//    _foodList.add(food);
//  });
//
//  foodNotifier.foodList = _foodList;
//  print(_foodList);
//}
