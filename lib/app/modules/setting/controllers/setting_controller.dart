import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:travel_guide/app/base/global_model/user_model.dart';
import 'package:flutter/material.dart';

import '../services/user_services.dart';
import '../views/dialog/edit_username_dialog.dart';

class SettingController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final UserServices userServices = UserServices();

  RxBool isLoading = false.obs;

  Rx<UserModel> userModel = UserModel(
    id: '',
    firstName: '',
    surName: '',
    email: '',
    longitude: 0,
    latitude: 0,
  ).obs;

  final firstNameController = TextEditingController();
  final surNameController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> fetchUser() async {
    isLoading.value = true;
    userModel.value = await userServices.getUser();
    isLoading.value = false;
  }

  Future<void> showEditUsernameDialog() async {
    // Pre-fill the text controllers
    firstNameController.text = userModel.value.firstName;
    surNameController.text = userModel.value.surName;

    await Get.dialog(
      EditUsernameDialog(
        firstNameController: firstNameController,
        surNameController: surNameController,
        onSave: updateUsername,
      ),
    );
  }

  Future<void> updateUsername() async {
    try {
      isLoading.value = true;
      await userServices.updateUsername(
        userId: auth.currentUser!.uid,
        firstName: firstNameController.text,
        surName: surNameController.text,
      );
      await fetchUser(); // Refresh user data
      Get.back(); // Close dialog
      Get.snackbar(
        'Success',
        'Username updated successfully',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update username',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    try {
      isLoading.value = true;

      // Get current user
      final user = auth.currentUser;
      if (user == null) throw Exception('No user logged in');

      // Get credentials for reauthentication
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      // Reauthenticate user
      await user.reauthenticateWithCredential(credential);

      // Change password
      await user.updatePassword(newPassword);

      Get.back(); // Close dialog
      Get.snackbar(
        'Success',
        'Password successfully updated',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';

      switch (e.code) {
        case 'wrong-password':
          message = 'Current password is incorrect';
          break;
        case 'weak-password':
          message = 'New password is too weak';
          break;
        case 'requires-recent-login':
          message = 'Please log in again to change your password';
          break;
        default:
          message = e.message ?? 'An error occurred';
      }

      Get.snackbar(
        'Error',
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      // Clear text controllers
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    surNameController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
