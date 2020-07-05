import 'package:flutter/material.dart';
import 'package:foodlab/api/food_api.dart';

import 'package:foodlab/notifier/auth_notifier.dart';
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Welcome to home page!'),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              signOutUser();
            },
            child: Text('logout'),
          ),
        ],
      ),
    );
  }
}
