import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../model/village_model.dart';

class VillageServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get all villages based on user's plan
  Future<List<VillageModel>> getVillages() async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId == null) {
        Get.toNamed(Routes.LOGIN);
        throw Exception('User not authenticated');
      }

      // Get user's plan
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        Get.offAllNamed(Routes.LOGIN);
        throw Exception('User document not found');
      }

      final userData = userDoc.data();
      final List<String> userPlan = List<String>.from(userData?['plan'] ?? []);

      if (userPlan.isEmpty) {
        Get.offAllNamed(Routes.PLAN);
        throw Exception('Choose your plan');
      }
      print(userPlan);

      // Get data from all collections in the plan
      List<VillageModel> allPlaces = [];

      for (String collection in userPlan) {
        final QuerySnapshot snapshot =
            await _firestore.collection(collection).get();

        final places = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return VillageModel.fromFirestore(data, doc.id);
        }).toList();

        allPlaces.addAll(places);
      }

      print(allPlaces);

      return allPlaces;
    } catch (e) {
      print('Error getting places: $e');
      rethrow;
    }
  }

  // Get village by id from specific collection
  Future<VillageModel?> getVillageById(String collectionName, String id) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('travel')
          .doc(collectionName)
          .collection('places')
          .doc(id)
          .get();

      if (doc.exists) {
        return VillageModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      print('Error getting place: $e');
      rethrow;
    }
  }

  // Get nearby villages (optional)
  Future<List<VillageModel>> getNearbyVillages(
      double latitude, double longitude, double radius) async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('User not authenticated');

      // Get user's plan
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final userData = userDoc.data();
      final List<String> userPlan = List<String>.from(userData?['plan'] ?? []);

      if (userPlan.isEmpty) return [];

      List<VillageModel> nearbyPlaces = [];

      for (String collection in userPlan) {
        final QuerySnapshot snapshot = await _firestore
            .collection('travel')
            .doc(collection)
            .collection('places')
            .get();

        final places = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return VillageModel.fromFirestore(data, doc.id);
        }).where((place) {
          // Calculate distance and filter based on radius
          final distance = calculateDistance(
            latitude,
            longitude,
            place.latitude,
            place.longitude,
          );
          return distance <= radius;
        }).toList();

        nearbyPlaces.addAll(places);
      }

      // Sort by distance
      nearbyPlaces.sort((a, b) {
        final distA =
            calculateDistance(latitude, longitude, a.latitude, a.longitude);
        final distB =
            calculateDistance(latitude, longitude, b.latitude, b.longitude);
        return distA.compareTo(distB);
      });

      return nearbyPlaces;
    } catch (e) {
      print('Error getting nearby places: $e');
      rethrow;
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    // Implement distance calculation (Haversine formula)
    // Return distance in kilometers
    // You can use a package like 'geolocator' for this
    return 0.0; // Placeholder
  }
}
