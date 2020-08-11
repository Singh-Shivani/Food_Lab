class User {
  String displayName;
  String email;
  String password;
  String uuid;
  String bio;

  User();

  User.fromMap(Map<String, dynamic> data) {
    displayName = data['displayName'];
    email = data['email'];
    password = data['password'];
    uuid = data['uuid'];
    bio = data['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'password': password,
      'uuid': uuid,
      'bio': bio,
    };
  }

//  void setBio(String userBio) {
//    this.bio = userBio;
//  }
//
//  Future<String> getBio() async {
//    return bio;
//  }
}
