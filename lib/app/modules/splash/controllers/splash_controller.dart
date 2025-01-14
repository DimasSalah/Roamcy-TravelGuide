import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../utils/local_storage/storage_utility.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  RxBool onBoarding = false.obs;
  RxDouble opacity = 0.0.obs;
  GLocalStorage localStorage = GLocalStorage();

  // final _auth = FirebaseAuth.instance;
  // late final Rx<User?> firebaseUser;

  _setInitialScreen() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (localStorage.readData<bool>('onboarding') == true) {
      localStorage.readData<bool>('isLoggedIn') == false
          ? Get.offAllNamed(Routes.LOGIN)
          : Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.ONBOARDING);
    }
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 100), () {
      opacity.value = 1.0;
    });
  }

  @override
  void onReady() {
    // firebaseUser = Rx<User?>(_auth.currentUser);
    // firebaseUser.bindStream(_auth.userChanges());
    // ever(firebaseUser, _setInitialScreen);
    _setInitialScreen();
    super.onReady();
  }
}
