import 'package:get/get.dart';

import '../modules/business/bindings/business_binding.dart';
import '../modules/business/views/business_view.dart';
import '../modules/clubs/bindings/clubs_binding.dart';
import '../modules/clubs/views/clubs_view.dart';
import '../modules/favorites/bindings/favorites_binding.dart';
import '../modules/favorites/views/favorites_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/plan/bindings/plan_binding.dart';
import '../modules/plan/views/plan_view.dart';
import '../modules/restaurants/bindings/restaurants_binding.dart';
import '../modules/restaurants/views/restaurants_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/village/bindings/village_binding.dart';
import '../modules/village/views/village_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES,
      page: () => const FavoritesView(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.BUSINESS,
      page: () => const BusinessView(),
      binding: BusinessBinding(),
    ),
    GetPage(
      name: _Paths.CLUBS,
      page: () => const ClubsView(),
      binding: ClubsBinding(),
    ),
    GetPage(
      name: _Paths.RESTAURANTS,
      page: () => const RestaurantsView(),
      binding: RestaurantsBinding(),
    ),
    GetPage(
      name: _Paths.VILLAGE,
      page: () => const VillageView(),
      binding: VillageBinding(),
    ),
    GetPage(
      name: _Paths.PLAN,
      page: () => const PlanView(),
      binding: PlanBinding(),
    ),
  ];
}
