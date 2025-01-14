import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../utils/constant/constant.dart';
import '../../../../../utils/widgets/card/global_details.dart';
import '../../../../../utils/widgets/card/global_place_card.dart';
import '../../controllers/village_controller.dart';

class VillageNearby extends GetView<VillageController> {
  const VillageNearby({super.key});

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
          height: Get.height * 0.2, // Sesuaikan tinggi container
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Gap(24),
                for (var village in controller.nearbyVillages.take(5))
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => GlobalDetails(
                          name: village.key.name,
                          imageUrl: village.key.imageLinks,
                          rating: village.key.rating,
                          mapsLink: village.key.mapsLink,
                          description: village.key.description,
                          activity: 'Travel',
                          latitude: village.key.latitude,
                          longitude: village.key.longitude,
                        ),
                      );
                    },
                    child: GlobalPlaceCard(
                        name: village.key.name,
                        image: village.key.imageLinks.first,
                        rating: village.key.rating,
                        distance: village.value),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
