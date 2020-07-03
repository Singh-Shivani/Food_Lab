import 'package:flutter/material.dart';
import 'package:foodlab/screens/login.dart';
import 'package:foodlab/notifier/auth_notifier.dart';
import 'package:provider/provider.dart';
import 'package:foodlab/screens/home_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null
              ? HomePage()
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(255, 138, 120, 1),
                        Color.fromRGBO(255, 114, 117, 1),
                        Color.fromRGBO(255, 63, 111, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'FoodLab',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'MuseoModerno',
                        ),
                      ),
                      Text(
                        'Think. Click. Pick',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 17,
                          color: Color.fromRGBO(252, 188, 126, 1),
                        ),
                      ),
                      SizedBox(
                        height: 140,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => LoginPage(),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Explore",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(255, 63, 111, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
