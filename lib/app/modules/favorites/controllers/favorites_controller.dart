import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../base/geolocation/app_location.dart';
import '../../../base/global_model/favorite_model.dart';
import '../data/services/favorites_service.dart';

class FavoritesController extends GetxController {
  final FavoritesService _favoritesService = FavoritesService();
  final RxList<FavoriteModel> favorites = <FavoriteModel>[].obs;
  final RxBool isLoading = false.obs;
  final AppLocation appLocation = AppLocation();
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  late PageController pageController;
  int currentImageIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _loadFavorites();

    getCurrentPosition();
    _initPageController();
  }

  void _initPageController() {
    pageController = PageController();
  }

  void setCurrentIndex(int index) {
    currentImageIndex = index;
    update();
  }

  void resetPageController() {
    pageController.dispose();
    _initPageController();
    currentImageIndex = 0;
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> getCurrentPosition() async {
    isLoading.value = true;
    Position position = await appLocation.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }

  double calculateDistance(double latitude, double longitude) {
    double distance = Geolocator.distanceBetween(
        this.latitude.value, this.longitude.value, latitude, longitude);

    return double.parse((distance / 1000).toStringAsFixed(1));
  }

  void _loadFavorites() {
    _favoritesService.getFavorites().listen(
      (updatedFavorites) {
        favorites.value = updatedFavorites;
      },
      onError: (error) {
        Get.snackbar(
          'Error',
          'Failed to load favorites',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  Future<void> toggleFavorite(
    String id,
    String name,
    double rating,
    List<String> imageUrls,
    String mapsLink,
    String description,
    String activity,
    double latitude,
    double longitude,
  ) async {
    try {
      isLoading.value = true;
      final isFavorite = await _favoritesService.isFavorite(id);

      if (isFavorite) {
        await _favoritesService.removeFromFavorites(id);
        Get.snackbar(
          'Success',
          'Removed from favorites',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        final favorite = FavoriteModel(
          id: id,
          name: name,
          rating: rating,
          imageUrls: imageUrls,
          mapsLink: mapsLink,
          description: description,
          activity: activity,
          latitude: latitude,
          longitude: longitude,
          addedAt: DateTime.now(),
        );
        await _favoritesService.addToFavorites(favorite);
        Get.snackbar(
          'Success',
          'Added to favorites',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update favorites',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
