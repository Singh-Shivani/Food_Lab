import 'package:flutter/material.dart';
import 'package:foodlab/api/food_api.dart';
import 'package:foodlab/model/user.dart';
import 'package:foodlab/model/user.dart';
import 'package:foodlab/notifier/auth_notifier.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User _user = User();

  @override
  void initState() {
    super.initState();
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
  }

  signoutUser() {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    if (authNotifier.user != null) {
      signOut(authNotifier);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Welcome to home page!'),
        SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: () {
            signoutUser();
          },
          child: Text('logout'),
        ),
      ],
    );
  }
}
