import 'package:flutter/material.dart';
import 'package:foodlab/screens/add_post.dart';
import 'package:foodlab/screens/home_page.dart';
import 'package:foodlab/screens/profile_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavigationBarPage extends StatefulWidget {
  @override
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    ImageCapture(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _children[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white.withOpacity(0.5),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.white,
        height: 50,
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: <Widget>[
          Icon(
            Icons.home,
            size: 26,
            color: Colors.black,
          ),
//          Color.fromRGBO(247, 27, 104, 1),
          Icon(
            Icons.add_box,
            size: 26,
            color: Colors.black,
          ),
          Icon(
            Icons.account_circle,
            size: 26,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
