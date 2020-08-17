import 'package:flutter/material.dart';
import 'package:foodlab/screens/add_post.dart';
import 'package:foodlab/screens/home_page.dart';
import 'package:foodlab/screens/profile_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavigationBarPage extends StatefulWidget {
  int selectedIndex;
  NavigationBarPage({@required this.selectedIndex});
  @override
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  final List<Widget> _children = [
    HomePage(),
    ImageCapture(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _children[widget.selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.white,
        height: 50,
        index: widget.selectedIndex,
        onTap: (index) {
          setState(() {
            widget.selectedIndex = index;
          });
        },
        items: <Widget>[
          Icon(
            Icons.home,
            size: 26,
            color: Colors.black,
          ),
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
