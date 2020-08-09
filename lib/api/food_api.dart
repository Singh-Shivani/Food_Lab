import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodlab/model/food.dart';
import 'package:foodlab/notifier/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodlab/model/user.dart';
import 'package:foodlab/screens/login_signup_page.dart';
import 'package:foodlab/screens/navigation_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

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
      await getUserDetails(authNotifier);
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
  bool userDataUploaded = false;
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
//      user.setBio(user.bio);

      uploadUserData(user, userDataUploaded);

      await getUserDetails(authNotifier);

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

uploadFoodAndImages(Food food, File localFile, BuildContext context) async {
  if (localFile != null) {
    print('uploading img file');

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$uuid$fileExtension');

    StorageUploadTask task = firebaseStorageRef.putFile(localFile);

    StorageTaskSnapshot taskSnapshot = await task.onComplete;

    String url = await taskSnapshot.ref.getDownloadURL();
    print('dw url $url');
    _uploadFood(food, context, imageUrl: url);
  } else {
    print('skipping img upload');
    _uploadFood(food, context);
  }
}

_uploadFood(Food food, BuildContext context, {String imageUrl}) async {
  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  CollectionReference foodRef = Firestore.instance.collection('foods');
  bool complete = true;
  if (imageUrl != null) {
    print(imageUrl);
    try {
      food.img = imageUrl;
      print(food.img);
    } catch (e) {
      print(e);
    }

    food.createdAt = Timestamp.now();
    food.userUuidOfPost = currentUser.uid;
    await foodRef
        .add(food.toMap())
        .catchError((e) => print(e))
        .then((value) => complete = true);

    print('uploaded food successfully');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return NavigationBarPage();
        },
      ),
    );
  }
  return complete;
}

uploadUserData(User user, bool userdataUpload) async {
  bool userDataUploadVar = userdataUpload;
  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

  CollectionReference userRef = Firestore.instance.collection('users');
  user.uuid = currentUser.uid;
  if (userDataUploadVar != true) {
    await userRef
        .document(currentUser.uid)
        .setData(user.toMap())
        .catchError((e) => print(e))
        .then((value) => userDataUploadVar = true);
  } else {
    print('already uploaded user data');
  }
  print('user data uploaded successfully');
}

getUserDetails(AuthNotifier authNotifier) async {
  await Firestore.instance
      .collection('users')
      .document(authNotifier.user.uid)
      .get()
      .catchError((e) => print(e))
      .then((value) => authNotifier.setUserDetails(User.fromMap(value.data)));
}
