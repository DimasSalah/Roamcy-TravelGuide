import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travel_guide/utils/widgets/card/global_details.dart';
import '../../../../utils/constant/constant.dart';
import '../../../../utils/widgets/app_bar/global_app_bar.dart';
import '../controllers/village_controller.dart';
import 'widgets/village_nearby.dart';
import '../../../../utils/widgets/card/global_card.dart';

class VillageView extends GetView<VillageController> {
  const VillageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GAppBar(
        title: 'Place to visit',
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VillageNearby(),
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
                itemCount: controller.allVillages.length,
                itemBuilder: (context, index) {
                  return GlobalCard(
                      name: controller.allVillages[index].key.name,
                      location: controller.allVillages[index].value,
                      rating: controller.allVillages[index].key.rating,
                      reviews: 0,
                      price: 0,
                      imageUrl:
                          controller.allVillages[index].key.imageLinks.first,
                      onTap: () {
                        Get.to(() => GlobalDetails(
                              name: controller.allVillages[index].key.name,
                              rating: controller.allVillages[index].key.rating,
                              description:
                                  controller.allVillages[index].key.description,
                              imageUrl:
                                  controller.allVillages[index].key.imageLinks,
                              mapsLink:
                                  controller.allVillages[index].key.mapsLink,
                              activity: 'Travel',
                              latitude:
                                  controller.allVillages[index].key.latitude,
                              longitude:
                                  controller.allVillages[index].key.longitude,
                            ));
                      });
                },
              ),
              // Widget lainnya...
            ],
          );
        }),
      ),
    );
  }
}
