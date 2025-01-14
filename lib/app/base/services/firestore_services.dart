import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  double randomRating() {
    return 4.0 + (Random().nextDouble() * (5.0 - 4.0));
  }

  Future<void> importBusinessData() async {
    try {
      // Baca file JSON dari assets
      final String jsonString =
          await rootBundle.loadString('assets/business.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      // Referensi ke collection 'business'
      final CollectionReference businessCollection =
          _firestore.collection('business');

      // Batch write untuk menulis banyak dokumen sekaligus
      WriteBatch batch = _firestore.batch();

      // Iterasi setiap data business
      for (var business in jsonData) {
        // Buat DocumentReference baru dengan ID otomatis
        DocumentReference docRef = businessCollection.doc();

        // Tambahkan data ke batch
        batch.set(docRef, {
          'name': business['nama'],
          'deskripsi': business['deskripsi'],
          'link': business['link'],
          'image_link': [business['image link']],
          'created_at': FieldValue.serverTimestamp(),
        });
      }

      // Commit batch write
      await batch.commit();
      print('Successfully imported business data to Firestore');
    } catch (e) {
      print('Error importing business data: $e');
      rethrow;
    }
  }

  Future<void> importRestaurantData() async {
    try {
      // Baca file JSON dari assets
      final String jsonString =
          await rootBundle.loadString('assets/Restaurants_JA.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      // Referensi ke collection 'restaurants'
      final CollectionReference restaurantCollection =
          _firestore.collection('restaurants');

      // Batch write untuk menulis banyak dokumen sekaligus
      WriteBatch batch = _firestore.batch();

      // Iterasi setiap data restaurant
      for (var restaurant in jsonData) {
        // Buat DocumentReference baru dengan ID otomatis
        DocumentReference docRef = restaurantCollection.doc();
        double rating = randomRating();

        // Tambahkan data ke batch
        batch.set(docRef, {
          'name': restaurant['Name'],
          'description': restaurant['description'],
          'mapsLink': restaurant['mapsLink'],
          'rating': rating,
          'latitude': restaurant['Latitude'],
          'longitude': restaurant['Longitude'],
          'imageLinks': [restaurant['imageLink']], // Simpan sebagai array
          'created_at': FieldValue.serverTimestamp(),
        });
      }

      // Commit batch write
      await batch.commit();
      print('Successfully imported restaurant data to Firestore');
    } catch (e) {
      print('Error importing restaurant data: $e');
      rethrow;
    }
  }

  Future<void> importClubData() async {
    try {
      // Baca file JSON dari assets
      final String jsonString =
          await rootBundle.loadString('assets/Clubs_JA.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      // Referensi ke collection 'clubs'
      final CollectionReference clubCollection =
          _firestore.collection('villages');

      // Batch write untuk menulis banyak dokumen sekaligus
      WriteBatch batch = _firestore.batch();

      // Iterasi setiap data club
      for (var club in jsonData) {
        // Buat DocumentReference baru dengan ID otomatis
        DocumentReference docRef = clubCollection.doc();

        // Tambahkan data ke batch
        batch.set(docRef, {
          'name': club['name'] ?? '',
          'description': club['description'] ?? '',
          'mapsLink': club['mapsLink'] ?? '',
          'latitude': club['latitude'] ?? 0.0,
          'longitude': club['longitude'] ?? 0.0,
          'imageLinks': [club['imageLink']], // Simpan sebagai array
          'rating': club['rating'] ?? 0.0,
          'created_at': FieldValue.serverTimestamp(),
        });
      }

      // Commit batch write
      await batch.commit();
      print('Successfully imported club data to Firestore');
    } catch (e) {
      print('Error importing club data: $e');
      rethrow;
    }
  }

  Future<void> importVillageData() async {
    try {
      // Baca file JSON dari assets
      final String jsonString =
          await rootBundle.loadString('assets/village_data.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      // Referensi ke collection 'villages'
      final CollectionReference villageCollection =
          _firestore.collection('villages');

      // Batch write untuk menulis banyak dokumen sekaligus
      WriteBatch batch = _firestore.batch();

      // Iterasi setiap data village
      for (var village in jsonData) {
        // Buat DocumentReference baru dengan ID otomatis
        DocumentReference docRef = villageCollection.doc();

        // Tambahkan data ke batch
        batch.set(docRef, {
          'name': village['Name'] ?? '',
          'description': village['description'] ?? '',
          'mapsLink': village['MapLink']?.trim() ?? '', // Menghapus whitespace
          'latitude': village['latitude'] ?? 0.0,
          'longitude': village['longitude'] ?? 0.0,
          'imageLinks': [village['imageLink']], // Simpan sebagai array
          'rating': village['rating'] ?? 0.0,
          'created_at': FieldValue.serverTimestamp(),
        });
      }

      // Commit batch write
      await batch.commit();
      print('Successfully imported village data to Firestore');
    } catch (e) {
      print('Error importing village data: $e');
      rethrow;
    }
  }

  Future<void> importNatureData() async {
    try {
      // Baca file JSON dari assets
      final String jsonString =
          await rootBundle.loadString('assets/sub/beach.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      // Referensi ke collection 'travel' dan subcollection 'historical'
      final CollectionReference travelCollection =
          _firestore.collection('beach');

      // Batch write untuk menulis banyak dokumen sekaligus
      WriteBatch batch = _firestore.batch();

      // Iterasi setiap data nature
      for (var nature in jsonData) {
        // Buat DocumentReference baru dengan ID otomatis
        DocumentReference docRef = travelCollection.doc();

        // Tambahkan data ke batch
        batch.set(docRef, {
          'name': nature['Name'] ?? '',
          'mapLink': nature['MapLink']?.trim() ?? '',
          'latitude': nature['latitude'] ?? 0.0,
          'longitude': nature['longitude'] ?? 0.0,
          'imageLink': [nature['imageLink']],
          'rating': nature['rating'] ?? 0.0,
          'description': nature['description'] ?? '',
          'created_at': FieldValue.serverTimestamp(),
        });
      }

      // Commit batch write
      await batch.commit();
      print('Successfully imported nature data to Firestore');
    } catch (e) {
      print('Error importing nature data: $e');
      rethrow;
    }
  }
}
