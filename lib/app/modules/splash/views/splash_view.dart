import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:travel_guide/utils/resources/resources.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => AnimatedOpacity(
            duration: const Duration(milliseconds: 1500),
            opacity: controller.opacity.value,
            child: Image.asset(Images.logo, width: Get.width * 0.5),
          ),
        ),
      ),
    );
  }
}
