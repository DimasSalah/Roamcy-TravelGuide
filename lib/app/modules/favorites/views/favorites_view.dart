import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import '../../../../utils/constant/constant.dart';
import '../../../../utils/widgets/app_bar/global_app_bar.dart';
import '../../../../utils/widgets/card/global_card.dart';
import '../../../../utils/widgets/card/global_details.dart';
import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GAppBar(title: 'My Favorites'),
      body: Obx(
        () => controller.favorites.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: GColors.primary,
                    ),
                    Gap(16),
                    Text(
                      'No favorites yet',
                      style: Poppins.semiBold.copyWith(
                        fontSize: 18,
                        color: GColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.favorites.length,
                itemBuilder: (context, index) {
                  final favorite = controller.favorites[index];
                  return GlobalCard(
                    name: favorite.name,
                    location: controller.calculateDistance(
                        favorite.latitude, favorite.longitude),
                    rating: favorite.rating,
                    reviews: 0,
                    price: 0,
                    imageUrl: favorite.imageUrls.first,
                    onTap: () {
                      Get.to(() => GlobalDetails(
                            name: favorite.name,
                            rating: favorite.rating,
                            imageUrl: favorite.imageUrls,
                            mapsLink: favorite.mapsLink,
                            description: favorite.description,
                            activity: favorite.activity,
                            latitude: favorite.latitude,
                            longitude: favorite.longitude,
                          ));
                    },
                  );
                },
              ),
      ),
    );
  }
}
