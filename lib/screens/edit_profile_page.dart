import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodlab/api/food_api.dart';
import 'package:foodlab/model/user.dart';
import 'package:foodlab/notifier/auth_notifier.dart';
import 'package:foodlab/screens/profile_page.dart';
import 'package:foodlab/widget/custom_raised_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

TextEditingController _editBioController = TextEditingController();
TextEditingController _editDisplayNameController = TextEditingController();
User _user = User();

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Edit'),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _editDisplayNameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _editBioController,
                  decoration: InputDecoration(
                    labelText: 'Bio',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  FirebaseUser currentUser =
                      await FirebaseAuth.instance.currentUser();

                  CollectionReference userRef =
                      Firestore.instance.collection('users');

                  AuthNotifier authNotifier =
                      Provider.of<AuthNotifier>(context, listen: false);

                  await userRef
                      .document(currentUser.uid)
                      .setData({
                        'bio': _user.bio,
                        'displayName': _user.displayName,
                      }, merge: true)
                      .catchError((e) => print(e))
                      .whenComplete(() => getUserDetails(authNotifier));

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return ProfilePage();
                    }),
                  );
                },
                child: CustomRaisedButton(buttonText: 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
