import 'package:get/get.dart';

import '../controllers/village_controller.dart';

class VillageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VillageController>(
      () => VillageController(),
    );
  }
}
