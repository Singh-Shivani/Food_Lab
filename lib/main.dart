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
        fontFamily: 'Raleway',
      ),
      home: Scaffold(
        body: LandingPage(),
      ),
    );
  }
}
