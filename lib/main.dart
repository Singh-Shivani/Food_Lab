import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/landing_page.dart';
import 'notifier/auth_notifier.dart';
import 'notifier/food_notifier.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthNotifier(),
      ),
      ChangeNotifierProvider(
        create: (_) => FoodNotifier(),
      ),
    ],
    child: MyApp(),
  ));
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
