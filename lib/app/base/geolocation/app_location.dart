import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../utils/logging/logger.dart';

class AppLocation extends GetxController {
  static AppLocation get instance => Get.find<AppLocation>();

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  Future<Position> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: Platform.isAndroid
            ? AndroidSettings(
                foregroundNotificationConfig: const ForegroundNotificationConfig(
                    notificationTitle: 'Location fetching in background',
                    notificationText:
                        'your current location is listened in the background',
                    enableWakeLock: true))
            : AppleSettings(
                accuracy: LocationAccuracy.high,
                activityType: ActivityType.fitness,
                showBackgroundLocationIndicator: false,
              ),
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      GLoggerHelper.debug(
          'current position: Latitude: ${latitude.value} Longitude: ${longitude.value}');
      return position;
    } catch (e) {
      throw Exception(e);
    }
  }
}
