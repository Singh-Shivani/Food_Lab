import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String name;
  String img;
  String caption;
  String userUuidOfPost;
  Timestamp createdAt;

  //User details
  String userName;
  String profilePictureOfUser;

  Food();

  Food.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    img = data['img'];
    caption = data['caption'];
    createdAt = data['createdAt'];
    userUuidOfPost = data['userUuidOfPost'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'img': img,
      'caption': caption,
      'createdAt': createdAt,
      'userUuidOfPost': userUuidOfPost,
    };
  }
}
