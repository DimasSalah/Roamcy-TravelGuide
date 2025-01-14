import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../base/geolocation/app_location.dart';
import '../data/models/restaurant_model.dart';
import '../data/services/restaurant_services.dart';

class RestaurantsController extends GetxController {
  final RestaurantServices restaurantServices = RestaurantServices();
  final AppLocation appLocation = AppLocation();

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  var nearbyRestaurants = <MapEntry<RestaurantModel, double>>[].obs;
  var allRestaurants = <MapEntry<RestaurantModel, double>>[].obs;
  RxBool isLoading = false.obs;

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

  @override
  void onInit() async {
    super.onInit();
    nearbyRestaurants.value = Get.arguments['nearbyRestaurants'];
    allRestaurants.value = Get.arguments['allRestaurants'];
    // await getCurrentPosition();
    // await fetchrestaurants();
  }

  // Future<void> fetchrestaurants() async {
  //   try {
  //     final restaurants = await restaurantServices.getRestaurants();
  //     final nearbyRestaurant = restaurants
  //         .map((restaurant) => MapEntry(restaurant,
  //             calculateDistance(restaurant.latitude, restaurant.longitude)))
  //         .toList()
  //       ..sort((a, b) => a.value.compareTo(b.value));
  //     this.nearbyRestaurants.value = nearbyRestaurant;
  //     this.restaurants.value = restaurants;
  //     isLoading.value = false;
  //   } catch (e) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to load villages',
  //         snackPosition: SnackPosition.TOP);
  //   }
  // }
}
