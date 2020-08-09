import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodlab/model/user.dart';

class AuthNotifier extends ChangeNotifier {
  FirebaseUser _user;

  FirebaseUser get user {
    return _user;
  }

  void setUser(FirebaseUser user) {
    _user = user;
    notifyListeners();
  }

  //Test
  User _userDetails;

  User get userDetails => _userDetails;

  setUserDetails(User user) {
    _userDetails = user;
    notifyListeners();
  }
}
