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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 30, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      signOutUser();
                    },
                    child: Icon(
                      Icons.person_add,
                    ),
                  ),
                ),
              ],
            ),
            authNotifier.userDetails.profilePic != null
                ? CircleAvatar(
                    radius: 40.0,
                    backgroundImage:
                        NetworkImage(authNotifier.userDetails.profilePic),
                    backgroundColor: Colors.transparent,
                  )
                : Container(
                    decoration: new BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    width: 100,
                    child: Icon(
                      Icons.person,
                      size: 70,
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            authNotifier.userDetails.displayName != null
                ? Text(
                    authNotifier.userDetails.displayName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'MuseoModerno',
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text("You don't have a user name"),
            authNotifier.userDetails.bio != null
                ? Text(
                    authNotifier.userDetails.bio,
                    style: TextStyle(fontSize: 15),
                  )
                : Text("No Bio"),
            SizedBox(
              height: 40,
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
            SizedBox(
              height: 20,
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: snapshot.data.documents[index]['img'] != null
                              ? GestureDetector(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      child: Image.network(
                                        snapshot.data.documents[index]['img'],
                                        fit: BoxFit.cover,
                                      ),
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
                              : Text("You haven't posted anything"),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
