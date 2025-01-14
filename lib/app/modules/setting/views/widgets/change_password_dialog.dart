import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_guide/utils/widgets/textfields/input_password.dart';
import '../../../../../utils/constant/constant.dart';
import '../../controllers/setting_controller.dart';

class ChangePasswordDialog extends GetView<SettingController> {
  const ChangePasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: GColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change Password',
              style: Nove.bold.copyWith(
                fontSize: 20,
                color: GColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            InputPassword(
              label: 'Current Password',
              controller: controller.currentPasswordController,
              hint: 'Current Password',
            ),
            const SizedBox(height: 16),
            InputPassword(
              label: 'New Password',
              controller: controller.newPasswordController,
              hint: 'New Password',
            ),
            const SizedBox(height: 16),
            InputPassword(
              label: 'Confirm New Password',
              controller: controller.confirmPasswordController,
              hint: 'Confirm New Password',
            ),
            const SizedBox(height: 24),
            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Cancel',
                          style: Poppins.medium.copyWith(
                            color: GColors.darkGrey,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (controller.newPasswordController.text !=
                              controller.confirmPasswordController.text) {
                            Get.snackbar(
                              'Error',
                              'New passwords do not match',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            return;
                          }
                          controller.changePassword(
                            controller.currentPasswordController.text,
                            controller.newPasswordController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Change Password',
                          style: Poppins.medium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )),
          ],
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const _PasswordTextField({
    required this.controller,
    required this.label,
  });

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: Poppins.medium.copyWith(
          color: GColors.darkGrey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: GColors.darkGrey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
