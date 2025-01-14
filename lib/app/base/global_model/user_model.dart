import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstName;
  final String surName;
  final String email;
  final double longitude;
  final double latitude;

  UserModel({
    required this.id,
    required this.firstName,
    required this.surName,
    required this.email,
    required this.longitude,
    required this.latitude,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      firstName: doc['firstName'],
      surName: doc['surName'],
      email: doc['email'],
      longitude: doc['longitude'],
      latitude: doc['latitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'surName': surName,
      'email': email,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
