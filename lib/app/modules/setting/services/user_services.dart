import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../base/global_model/user_model.dart';

class UserServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<UserModel> getUser() async {
    try {
      final user = auth.currentUser;
      if (user == null) throw Exception('User not found');

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) throw Exception('User document not found');

      return UserModel(
        id: user.uid,
        firstName: userDoc.data()?['firstName'] ?? '',
        surName: userDoc.data()?['surName'] ?? '',
        email: userDoc.data()?['email'] ?? '',
        longitude: userDoc.data()?['longitude'] ?? 0.0,
        latitude: userDoc.data()?['latitude'] ?? 0.0,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateUsername({
    required String userId,
    required String firstName,
    required String surName,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'firstName': firstName,
        'surName': surName,
      });
    } catch (e) {
      throw Exception('Failed to update username: $e');
    }
  }
}
