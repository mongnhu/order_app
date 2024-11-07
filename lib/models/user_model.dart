import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String avatarUrl; // Add other fields as needed

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.avatarUrl,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      email: doc['email'],
      name: doc['name'],
      phone: doc['phone'],
      avatarUrl: doc['avatarUrl'] ?? '', // Handle missing fields appropriately
    );
  }
}
