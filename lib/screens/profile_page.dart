import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodlab/api/food_api.dart';
import 'package:foodlab/model/food.dart';
import 'package:foodlab/notifier/auth_notifier.dart';
import 'package:foodlab/screens/detail_food_page.dart';
import 'package:foodlab/screens/edit_profile_page.dart';
import 'package:foodlab/widget/custom_raised_button.dart';
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
        physics: BouncingScrollPhysics(),
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
                      authNotifier.userDetails.displayName != null
                          ? Text(
                              authNotifier.userDetails.displayName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'MuseoModerno',
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text('Please provide name'),
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

            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('foods')
                  .where('userUuidOfPost',
                      isEqualTo: authNotifier.userDetails.uuid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('no data');
                } else {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: snapshot.data.documents[index]['img'] != null
                                ? GestureDetector(
                                    child: Container(
                                      child: Image.network(
                                        snapshot.data.documents[index]['img'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return FoodDetailPage(
                                            foodDetail:
                                                snapshot.data.documents[index],
                                          );
                                        },
                                      ));
                                    },
                                  )
                                : CircularProgressIndicator(
                                    backgroundColor:
                                        Color.fromRGBO(255, 63, 111, 1),
                                  ),
                          ),
                        );
                      });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
