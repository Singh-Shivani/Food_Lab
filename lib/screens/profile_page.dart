import 'package:flutter/material.dart';
import 'package:foodlab/api/food_api.dart';
import 'package:foodlab/notifier/auth_notifier.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: GestureDetector(
          onTap: () {
            signOutUser();
          },
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
