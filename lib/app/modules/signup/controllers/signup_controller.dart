import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../utils/local_storage/storage_utility.dart';
import '../../../base/geolocation/app_location.dart';
import '../../../base/services/authentication_services.dart';
import '../../../routes/app_pages.dart';

class SignupController extends GetxController {
  final AuthenticationServices authenticationServices =
      AuthenticationServices();
  final AppLocation appLocation = AppLocation();

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxBool isLoading = false.obs;
  RxBool rule1 = false.obs;
  RxBool rule2 = false.obs;
  TextEditingController firstName = TextEditingController();
  TextEditingController surName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String? validatePasswordMatch(
      String? passwordValue, String? confirmPasswordValue) {
    if (passwordValue == confirmPasswordValue) {
      return null;
    } else {
      return "Passwords don't match";
    }
  }

  void getLatLong() async {
    Position position = await appLocation.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }

  Future<void> signup(
      {required GlobalKey<FormState> formKey,
      required String firstName,
      required String surName,
      required String email,
      required String password,
      required String confirmPassword}) async {
    try {
      if (!rule1.value || !rule2.value) {
        Get.snackbar(
          'Error',
          !rule1.value && !rule2.value
              ? 'Please confirm that you are 18 or over and agree to Terms and Conditions'
              : !rule1.value
                  ? 'Please confirm that you are 18 or over'
                  : 'Please agree to Terms and Conditions',
          duration: Duration(seconds: 3),
        );
        return;
      }

      if (formKey.currentState!.validate() &&
          validatePasswordMatch(password, confirmPassword) == null) {
        isLoading.value = true;
        update();
        await authenticationServices.registerWithEmailAndPassword(firstName,
            surName, email, password, latitude.value, longitude.value);
        isLoading.value = false;
        update();
        GLocalStorage().saveData('isLoggedIn', true);
        Get.offNamed(Routes.PLAN);
      } else {
        Get.snackbar(
            'Error', 'Please check all required fields are filled correctly');
        isLoading.value = false;
        update();
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: "An error occurred",
        duration: Duration(seconds: 5),
      ));
      isLoading.value = false;
      update();
    }
  }

  Future<void> signupWithGoogle() async {
    await authenticationServices.signInWithGoogle(
        longitude: longitude.value, latitude: latitude.value);
  }

  Future<void> signupWithApple() async {
    await authenticationServices.signInWithApple(
        longitude: longitude.value, latitude: latitude.value);
    Get.offNamed(Routes.PLAN);
  }

  final count = 0.obs;
  @override
  void onInit() {
    getLatLong();
    super.onInit();
  }

  void toggleRule1() {
    rule1.value = !rule1.value;
  }

  void toggleRule2() {
    rule2.value = !rule2.value;
  }
}
