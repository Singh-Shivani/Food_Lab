import 'package:flutter/material.dart';
import 'package:foodlab/screens/login.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  'FoodLab',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'MuseoModerno',
                  ),
                ),
              ),
              Text(
                'Think. Click. Pick',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  color: Color.fromRGBO(252, 188, 126, 1),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Color.fromRGBO(255, 63, 111, 1),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'User name',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                    icon: Icon(
                      Icons.account_circle,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                  ),
                ),
              ), //User Name TEXT FIELD
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Color.fromRGBO(255, 63, 111, 1),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                    icon: Icon(
                      Icons.email,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                  ),
                ),
              ), //EMAIL TEXT FIELD
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Color.fromRGBO(255, 63, 111, 1),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                  ),
                ),
              ), //PASSWORD TEXT FIELD
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Color.fromRGBO(255, 63, 111, 1),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Rewrite Password',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                  ),
                ),
              ), // RE-PASSWORD TEXT FIELD
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  //TODO:2 Signup Succesfully then dashboard page
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ), //LOGIN BUTTON
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already a registered user?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 10,
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
                      child: Text(
                        'Log In here',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
