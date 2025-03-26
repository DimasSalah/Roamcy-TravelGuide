import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../utils/local_storage/storage_utility.dart';
import '../../../base/geolocation/app_location.dart';
import '../../../base/services/authentication_services.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final AppLocation appLocation = AppLocation();
  final AuthenticationServices authenticationServices =
      AuthenticationServices();

  final isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final isKeepMeLoggedIn = false.obs;
  void getLatLong() async {
    Position position = await appLocation.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }

  Future<void> login(
      {required GlobalKey<FormState> formKey,
      required String email,
      required String password}) async {
    try {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        update();
        await authenticationServices.loginWithEmailAndPassword(email, password);
        isLoading.value = false;
        update();
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.showSnackbar(const GetSnackBar(
          message: "Some fields contain errors",
          duration: Duration(seconds: 5),
        ));
        isLoading.value = false;
        update();
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        message: "An error occurred",
        duration: Duration(seconds: 5),
      ));
      isLoading.value = false;
      update();
    }
  }

  Future<void> loginWithGoogle() async {
    await authenticationServices.signInWithGoogle(
        longitude: longitude.value, latitude: latitude.value);
  }

  Future<void> loginWithApple() async {
    await authenticationServices.signInWithApple(
        longitude: longitude.value, latitude: latitude.value);
  }

  final count = 0.obs;
  @override
  void onInit() {
    getLatLong();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  void toggleKeepMeLoggedIn() {
    isKeepMeLoggedIn.value = !isKeepMeLoggedIn.value;
  }
}
