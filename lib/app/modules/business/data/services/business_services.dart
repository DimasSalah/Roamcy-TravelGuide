import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/business_model.dart';

class BusinessServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get all business data
  Stream<List<BusinessModel>> getBusinesses() {
    return _firestore
        .collection('business')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return BusinessModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  // get business detail by id
  Future<BusinessModel?> getBusinessById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('business').doc(id).get();
      if (doc.exists) {
        return BusinessModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      print('Error getting business: $e');
      rethrow;
    }
  }

  // search business by name
  Stream<List<BusinessModel>> searchBusinesses(String query) {
    return _firestore
        .collection('business')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return BusinessModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  // add business
  Future<void> addBusiness(BusinessModel business) async {
    try {
      await _firestore.collection('business').add(business.toMap());
    } catch (e) {
      print('Error adding business: $e');
      rethrow;
    }
  }

  // update business
  Future<void> updateBusiness(String id, BusinessModel business) async {
    try {
      await _firestore.collection('business').doc(id).update(business.toMap());
    } catch (e) {
      print('Error updating business: $e');
      rethrow;
    }
  }

  // delete business
  Future<void> deleteBusiness(String id) async {
    try {
      await _firestore.collection('business').doc(id).delete();
    } catch (e) {
      print('Error deleting business: $e');
      rethrow;
    }
  }
}
