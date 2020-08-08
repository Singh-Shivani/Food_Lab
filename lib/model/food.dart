import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
//  String id;
  String name;
  String img;
  String caption;
  Timestamp createdAt;

  Food();
  Food.fromMap(Map<String, dynamic> data) {
//    id = data['id'];
    name = data['name'];
    img = data['img'];
    caption = data['caption'];
    createdAt = data['createdAt'];
  }

  Map<String, dynamic> toMap() {
    return {
//      'id': id,
      'name': name,
      'img': img,
      'caption': caption,
      'createdAt': createdAt,
    };
  }
}
