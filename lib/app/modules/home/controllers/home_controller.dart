import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_guide/app/modules/home/data/models/weather_model.dart';

import '../../../base/geolocation/app_location.dart';
import '../../../base/services/firestore_services.dart';
import '../../restaurants/data/models/restaurant_model.dart';
import '../../restaurants/data/services/restaurant_services.dart';
import '../../village/data/model/village_model.dart';
import '../../village/data/services/villages_services.dart';
import '../data/services/weather_services.dart';

class HomeController extends GetxController {
  final WeatherServices weatherServices = WeatherServices();
  final VillageServices villageServices = VillageServices();
  final RestaurantServices restaurantServices = RestaurantServices();
  final AppLocation appLocation = AppLocation();

  var nearbyRestaurants = <MapEntry<RestaurantModel, double>>[].obs;
  var allRestaurants = <MapEntry<RestaurantModel, double>>[].obs;

  var nearbyVillages = <MapEntry<VillageModel, double>>[].obs;
  var allVillages = <MapEntry<VillageModel, double>>[].obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingVillage = false.obs;
  RxBool isLoadingRestaurant = false.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  Rx<WeatherModel> weatherModel = Rx<WeatherModel>(WeatherModel(
    cityName: 'Unknown',
    temperature: 0,
    mainCondition: 'Unknown',
  ));

  double calculateDistance(double latitude, double longitude) {
    double distance = Geolocator.distanceBetween(
        this.latitude.value, this.longitude.value, latitude, longitude);
    return double.parse((distance / 1000).toStringAsFixed(1));
  }

  Future<void> fetchWeather() async {
    Position position = await appLocation.getCurrentPosition();
    WeatherModel weather = await weatherServices.getWeather(position);
    weatherModel.value = weather;
    // print(weatherModel.value.cityName);
  }

  Future<void> getCurrentPosition() async {
    isLoading.value = true;
    Position position = await appLocation.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }

  final count = 0.obs;
  @override
  void onInit() async {
    await initData();
    super.onInit();
  }

  Future<void> initData() async {
    await getCurrentPosition();
    fetchrestaurants();
    fetchVillages();
    await fetchWeather();
    print('get all data');
  }

  Future<void> fetchrestaurants() async {
    isLoadingRestaurant.value = true;
    try {
      final restaurants = await restaurantServices.getRestaurants();
      final nearbyRestaurant = restaurants
          .map((restaurant) => MapEntry(restaurant,
              calculateDistance(restaurant.latitude, restaurant.longitude)))
          .toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      final allRestaurants = restaurants
          .map((restaurant) => MapEntry(restaurant,
              calculateDistance(restaurant.latitude, restaurant.longitude)))
          .toList();
      this.nearbyRestaurants.value = nearbyRestaurant;
      this.allRestaurants.value = allRestaurants;
      isLoadingRestaurant.value = false;
    } catch (e) {
      isLoadingRestaurant.value = false;
      Get.snackbar('Error', 'user not authenticated, please login',
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> fetchVillages() async {
    isLoadingVillage.value = true;
    try {
      final villages = await villageServices.getVillages();
      print('get all villages');
      final nearbyVillages = villages
          .map((village) => MapEntry(
              village, calculateDistance(village.latitude, village.longitude)))
          .toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      final allVillages = villages
          .map((village) => MapEntry(
              village, calculateDistance(village.latitude, village.longitude)))
          .toList();
      this.nearbyVillages.value = nearbyVillages;
      this.allVillages.value = allVillages;
      isLoadingVillage.value = false;
      print('kontol');
      print(nearbyVillages);
    } catch (e) {
      isLoadingVillage.value = false;
      Get.snackbar('Error', 'Failed to load villages',
          snackPosition: SnackPosition.TOP);
    }
  }

  void importData() async {
    final FirestoreServices firestoreServices = FirestoreServices();
    try {
      await firestoreServices.importNatureData();
      Get.snackbar(
        'Success',
        'Business data successfully imported',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to import business data: $e',
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
