import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodlab/api/food_api.dart';
import 'package:foodlab/model/user.dart';
import 'package:foodlab/notifier/auth_notifier.dart';
import 'package:foodlab/screens/navigation_bar.dart';
import 'package:foodlab/widget/custom_raised_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

TextEditingController _editBioController = TextEditingController();
TextEditingController _editDisplayNameController = TextEditingController();

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User _user = User();
  File _profileImageFile;

  Future<void> _pickImage() async {
    final selected = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _profileImageFile = File(selected.path);
    });
  }

  void _clear() {
    setState(() {
      _profileImageFile = null;
    });
  }

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
              _profileImageFile != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: FileImage(_profileImageFile),
                          radius: 60,
                        ),
                        FlatButton(
                          child: Icon(Icons.refresh),
                          onPressed: _clear,
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: new BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              width: 100,
                              child: Icon(
                                Icons.person,
                                size: 80,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Select Profile Image',
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  autovalidate: true,
                  controller: _editDisplayNameController
                    ..text = authNotifier.userDetails.displayName,
                  onSaved: (String value) {
                    _user.displayName = value;
                  },
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
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _editBioController
                    ..text = authNotifier.userDetails.bio,
                  onChanged: (String value) {
                    _user.bio = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Bio',
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              GestureDetector(
                child: CustomRaisedButton(buttonText: 'Save'),
                onTap: () async {
                  await uploadProfilePic(_profileImageFile, _user);

                  _user.displayName = _editDisplayNameController.text;
                  _user.bio = _editBioController.text;
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
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return NavigationBarPage(selectedIndex: 2);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
