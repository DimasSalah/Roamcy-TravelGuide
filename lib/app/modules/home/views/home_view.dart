import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:travel_guide/utils/widgets/button/button_primary.dart';

import '../../../../utils/constant/constant.dart';
import '../../../../utils/helper/time_format.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'widgets/card/menu_card.dart';
import 'widgets/popupmenu/custom_setting_menu.dart';
import 'widgets/indicator/custom_time_weather.dart';
import 'widgets/card/lunch_card.dart';
import 'widgets/card/lunch_card_loading.dart';
import 'widgets/card/village_card.dart';
import 'widgets/card/village_card_loading.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CSettingMenu(),
          leadingWidth: 70,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20),
                Text(
                  'Welcome Back',
                  style: Nove.semiBold
                      .copyWith(fontSize: 34, color: GColors.primary),
                ),
                Gap(10),
                Obx(() => CTimeWeather(
                      weather: controller.weatherModel.value.mainCondition,
                      temperature: controller.weatherModel.value.temperature,
                    )),
                Gap(10),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: GColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(10),
                      Text(GFormat.mealTime(DateTime.now()),
                          style: Nove.semiBold.copyWith(
                              fontSize: 18, color: GColors.backgroundField)),
                      Text('Check out places near-by',
                          style: Poppins.semiBold.copyWith(
                              fontSize: 12, color: GColors.backgroundField)),
                      Gap(10),
                      Obx(() {
                        return controller.isLoadingRestaurant.value
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                    3,
                                    (index) => Skeletonizer(
                                        enabled: true,
                                        child: LunchCardLoading())),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  for (var restaurant
                                      in controller.nearbyRestaurants.take(3))
                                    LunchCard(
                                      restaurant: restaurant,
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.RESTAURANTS,
                                          arguments: {
                                            'nearbyRestaurants':
                                                controller.nearbyRestaurants,
                                            'allRestaurants':
                                                controller.allRestaurants
                                          },
                                        );
                                      },
                                    )
                                ],
                              );
                      }),
                    ],
                  ),
                ),
                Gap(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.VILLAGE, arguments: {
                            'nearbyVillages': controller.nearbyVillages,
                            'allVillages': controller.allVillages
                          });
                        },
                        child: Obx(
                          () {
                            return controller.isLoadingVillage.value
                                ? Skeletonizer(
                                    enabled: true,
                                    child: VillageCardLoading(),
                                  )
                                : VillageCard(
                                    village: controller.nearbyVillages.first);
                          },
                        ),
                      ),
                    ),
                    Gap(Get.width * 0.03),
                    MenuCard(),
                  ],
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     controller.importData();
                //   },
                //   child: Text('Import Data'),
                // )
              ],
            ),
          ),
        ));
  }
}
