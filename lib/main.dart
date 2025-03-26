import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_guide/firebase_options.dart';
import 'app/base/geolocation/app_location.dart';
import 'app/routes/app_pages.dart';
import 'utils/local_storage/storage_utility.dart';
import 'utils/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GLocalStorage().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
    ),
  );

  // Daftarkan AppLocation sebagai dependency
  Get.put(AppLocation());
}

Future configureApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await MellotippetFirebaseRemoteConfig.initialize();
  await GLocalStorage().init();
  // await _setupNotifications();
//
  // Get
  //GLOBAL
  // ..put(AppLocation());
  // ..put(firebaseRemoteConfig)
}
