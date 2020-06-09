import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class UserModel extends ChangeNotifier{
  final String id;
  final String name;
  final String phone;
  final String address;
  final String skills;
  final double age;
  final String imageUrl;


  UserModel({
    this.id,
    this.address,
    this.age,

    this.name,
    this.phone,
    this.skills,
    this.imageUrl
  });
  factory UserModel.fromDoc(DocumentSnapshot doc){
    return UserModel(
      id: doc.documentID,
       imageUrl: doc['imageUrl'],
      name: doc['name'],
      phone: doc['phone'],
      skills: doc['skills'],
      age: doc['age'],
      address: doc['address'],
      // facebookUrl: doc['facebookUrl'] ?? '',

    );
  }

}