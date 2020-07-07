import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String id;
  String name;
  String img;
  Timestamp createdAt;

  Food.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    img = data['img'];
    createdAt = data['createdAt'];
  }
}
