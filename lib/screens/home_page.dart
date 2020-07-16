import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodlab/api/food_api.dart';

import 'package:foodlab/notifier/auth_notifier.dart';
import 'package:foodlab/notifier/food_notifier.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  signOutUser() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    if (authNotifier.user != null) {
      signOut(authNotifier, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    print('building home');
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SafeArea(
                child: authNotifier.user != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Hey, ',
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                authNotifier.user.displayName + '!',
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 63, 111, 1),
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                signOutUser();
                              },
                              child: Text('Sign Out'))
                        ],
                      )
                    : Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 17,
                          color: Color.fromRGBO(255, 63, 111, 1),
                        ),
                      ),
              ),
            ),
            Text(
              'Explore',
              style: TextStyle(
                color: Color.fromRGBO(255, 63, 111, 1),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            StreamBuilder(
                stream: Firestore.instance.collection('foods').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        Text(
                          '\nloading...\n',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 63, 111, 1),
                          ),
                        ),
                        CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(255, 63, 111, 1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(255, 138, 120, 1)),
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Padding(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: snapshot.data.documents[index]
                                                ['img'] !=
                                            null
                                        ? Image.network(
                                            snapshot.data.documents[index]
                                                ['img'],
                                            fit: BoxFit.fitWidth,
                                          )
                                        : CircularProgressIndicator(),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10),
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data.documents[index]['name'],
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      snapshot.data.documents[index]['caption'],
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        });
                  }
                }),
          ],
        ),
      ),
    );
  }
}