import 'package:flutter/material.dart';
import 'screens/landingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Lab',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: Color.fromRGBO(255, 63, 111, 1),
      ),
      home: Scaffold(
        body: LandingPage(),
      ),
    );
  }
}
