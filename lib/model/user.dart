import 'dart:io';

class User {
  String displayName;
  String email;
  String password;
  String uuid;
  String bio;
  String profilePic;
  File profileFile;

  User();

  User.fromMap(Map<String, dynamic> data) {
    displayName = data['displayName'];
    email = data['email'];
    password = data['password'];
    uuid = data['uuid'];
    bio = data['bio'];
    profilePic = data['profilePic'];
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'password': password,
      'uuid': uuid,
      'bio': bio,
      'profilePic': profilePic,
    };
  }
}
