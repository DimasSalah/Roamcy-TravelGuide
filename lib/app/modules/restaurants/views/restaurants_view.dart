import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../../utils/constant/constant.dart';
import '../../../../utils/helper/time_format.dart';
import '../../../../utils/widgets/app_bar/global_app_bar.dart';
import '../../../../utils/widgets/card/global_card.dart';
import '../../../../utils/widgets/card/global_details.dart';
import '../controllers/restaurants_controller.dart';
import 'widgets/restaurant_nearby.dart';

class RestaurantsView extends GetView<RestaurantsController> {
  const RestaurantsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GAppBar(
        title: GFormat.mealTime(DateTime.now()),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RestaurantNearby(),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'All Places',
                  style: Poppins.semiBold.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.allRestaurants.length,
                itemBuilder: (context, index) {
                  return GlobalCard(
                      name: controller.allRestaurants[index].key.name,
                      location: controller.allRestaurants[index].value,
                      rating: controller.allRestaurants[index].key.rating,
                      reviews: 0,
                      price: 0,
                      imageUrl:
                          controller.allRestaurants[index].key.imageLinks.first,
                      onTap: () {
                        Get.to(
                          () => GlobalDetails(
                            name: controller.allRestaurants[index].key.name,
                            rating: controller.allRestaurants[index].key.rating,
                            imageUrl:
                                controller.allRestaurants[index].key.imageLinks,
                            mapsLink:
                                controller.allRestaurants[index].key.mapsLink,
                            description: controller
                                .allRestaurants[index].key.description,
                            activity: 'Meal',
                            latitude:
                                controller.allRestaurants[index].key.latitude,
                            longitude:
                                controller.allRestaurants[index].key.longitude,
                          ),
                        );
                      });
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
