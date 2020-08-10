import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodlab/api/food_api.dart';
import 'package:foodlab/model/user.dart';
import 'package:foodlab/notifier/auth_notifier.dart';
import 'package:foodlab/screens/edit_profile_page.dart';
import 'package:foodlab/widget/custom_raised_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  signOutUser() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    if (authNotifier.user != null) {
      signOut(authNotifier, context);
    }
  }

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    getUserDetails(authNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'My Profile',
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: GestureDetector(
                      onTap: () {
                        signOutUser();
                      },
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 63, 111, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ), //HeaderInfoOfUser
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('User Profile Image'),
                  Column(
                    children: <Widget>[
                      Text(
                        authNotifier.userDetails.displayName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'MuseoModerno',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      authNotifier.userDetails.bio != null
                          ? Text(authNotifier.userDetails.bio)
                          : Text("No Bio"),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return EditProfile();
                            }),
                          );
                        },
                        child: CustomRaisedButton(buttonText: 'Edit Profile'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

//_userEditBottomSheet(BuildContext context) {
//  showModalBottomSheet(
//      context: context,
//      builder: (context) {
//        return Container(
//          height: MediaQuery.of(context).size.height * 0.6,
//          child: SingleChildScrollView(
//            physics: BouncingScrollPhysics(),
//            child: Column(
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 20),
//                  child: TextField(
//                    controller: _editProfileController,
//                    decoration: InputDecoration(
//                      labelText: 'Bio',
//                    ),
//                  ),
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                GestureDetector(
//                  onTap: () async {
//                    _user.bio = _editProfileController.text;
//                    FirebaseUser currentUser =
//                        await FirebaseAuth.instance.currentUser();
//
//                    CollectionReference userRef =
//                        Firestore.instance.collection('users');
//
//                    AuthNotifier authNotifier =
//                        Provider.of<AuthNotifier>(context, listen: false);
//
//                    await userRef
//                        .document(currentUser.uid)
//                        .setData({'bio': _user.bio}, merge: true)
//                        .catchError((e) => print(e))
//                        .whenComplete(() => getUserDetails(authNotifier));
//
//                    Navigator.pop(context);
//                  },
//                  child: Container(
//                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                    decoration: BoxDecoration(
//                      gradient: LinearGradient(
//                        colors: [
//                          Color.fromRGBO(255, 138, 120, 1),
//                          Color.fromRGBO(255, 114, 117, 1),
//                          Color.fromRGBO(255, 63, 111, 1),
//                        ],
//                        begin: Alignment.centerLeft,
//                        end: Alignment.centerRight,
//                      ),
//                      borderRadius: BorderRadius.circular(40),
//                    ),
//                    child: Text(
//                      'Save',
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        );
//      });
//}
