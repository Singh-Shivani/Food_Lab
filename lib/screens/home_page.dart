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
  void initState() {
    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);
    getFoods(foodNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    print('building home');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          authNotifier.user != null
              ? 'Hello ' + authNotifier.user.displayName
              : 'Home Page',
        ),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Image.network(
              foodNotifier.foodList[0].img,
              width: 200,
            ),
            title: Text(
              foodNotifier.foodList[0].name,
              style: TextStyle(color: Colors.black, fontSize: 23),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 20);
        },
        itemCount: foodNotifier.foodList.length,
      ),
    );
  }
}
//Text(
//snapshot.data.documents[0]['name'],
//),
