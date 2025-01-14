import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlanServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> savePlan(List<String> selectedPlan) async {
    try {
      final String? userId = _auth.currentUser?.uid;

      if (userId == null) {
        throw Exception('User not authenticated');
      }

      await _firestore.collection('users').doc(userId).update({
        'plan': selectedPlan,
        'updated_at': FieldValue.serverTimestamp(),
      });

      print('Plan saved successfully: $selectedPlan');
    } catch (e) {
      print('Error saving plan: $e');
      throw Exception('Failed to save plan: $e');
    }
  }

  Future<List<String>> getUserPlan() async {
    try {
      final String? userId = _auth.currentUser?.uid;

      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();

      if (!doc.exists || !doc.data().toString().contains('plan')) {
        return [];
      }

      final data = doc.data() as Map<String, dynamic>;
      return List<String>.from(data['plan'] ?? []);
    } catch (e) {
      print('Error getting user plan: $e');
      return [];
    }
  }
}
