import 'package:get/get.dart';

import '../../favorites/controllers/favorites_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FavoritesController>(
      FavoritesController(),
      permanent: true,
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
