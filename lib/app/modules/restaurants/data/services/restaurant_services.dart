import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/restaurant_model.dart';

class RestaurantServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all restaurants
  Future<List<RestaurantModel>> getRestaurants() {
    return _firestore
        .collection('restaurants')
        .orderBy('created_at', descending: true)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        return RestaurantModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  // Get restaurant by id
  Future<RestaurantModel?> getRestaurantById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('restaurants').doc(id).get();
      if (doc.exists) {
        return RestaurantModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      print('Error getting restaurant: $e');
      rethrow;
    }
  }
}
