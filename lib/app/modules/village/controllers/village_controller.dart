import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../base/geolocation/app_location.dart';
import '../data/model/village_model.dart';
import '../data/services/villages_services.dart';

class VillageController extends GetxController {
  final VillageServices villageServices = VillageServices();
  final AppLocation appLocation = AppLocation();

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  var nearbyVillages = <MapEntry<VillageModel, double>>[].obs;
  var allVillages = <MapEntry<VillageModel, double>>[].obs;
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
    nearbyVillages.value = Get.arguments['nearbyVillages'];
    allVillages.value = Get.arguments['allVillages'];
    // await getCurrentPosition();
    // await fetchVillages();
  }

  // Future<void> fetchVillages() async {
  //   try {
  //     final villages = await villageServices.getVillages();
  //     final nearbyVillages = villages
  //         .map((village) => MapEntry(
  //             village, calculateDistance(village.latitude, village.longitude)))
  //         .toList()
  //       ..sort((a, b) => a.value.compareTo(b.value));
  //     this.nearbyVillages.value = nearbyVillages;
  //     this.villages.value = villages;
  //     isLoading.value = false;
  //   } catch (e) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to load villages',
  //         snackPosition: SnackPosition.TOP);
  //   }
  // }
}
