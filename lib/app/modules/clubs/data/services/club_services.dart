import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/club_model.dart';

class ClubServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all clubs
  Stream<List<ClubModel>> getClubs() {
    return _firestore
        .collection('clubs')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ClubModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  // Get club by id
  Future<ClubModel?> getClubById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('clubs').doc(id).get();
      if (doc.exists) {
        return ClubModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      print('Error getting club: $e');
      rethrow;
    }
  }
}
