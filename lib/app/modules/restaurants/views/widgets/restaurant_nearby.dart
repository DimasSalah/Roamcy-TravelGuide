import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../utils/constant/constant.dart';
import '../../../../../utils/widgets/card/global_details.dart';
import '../../../../../utils/widgets/card/global_place_card.dart';
import '../../controllers/restaurants_controller.dart';

class RestaurantNearby extends GetView<RestaurantsController> {
  const RestaurantNearby({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Nearby places',
            style: Poppins.semiBold.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Gap(24),
                for (var restaurant in controller.nearbyRestaurants.take(5))
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => GlobalDetails(
                          name: restaurant.key.name,
                          imageUrl: restaurant.key.imageLinks,
                          rating: restaurant.key.rating,
                          mapsLink: restaurant.key.mapsLink,
                          description: restaurant.key.description,
                          activity: 'Meal',
                          latitude: restaurant.key.latitude,
                          longitude: restaurant.key.longitude,
                        ),
                      );
                    },
                    child: GlobalPlaceCard(
                        name: restaurant.key.name,
                        image: restaurant.key.imageLinks.first,
                        rating: restaurant.key.rating,
                        distance: restaurant.value),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
