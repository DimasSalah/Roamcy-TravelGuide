import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:travel_guide/app/modules/favorites/controllers/favorites_controller.dart';

import '../../constant/constant.dart';

class GlobalDetails extends GetView<FavoritesController> {
  final String name;
  // final String location;
  final double rating;
  final List<String> imageUrl;
  final String mapsLink;
  final String description;
  final String activity;
  final double latitude;
  final double longitude;
  const GlobalDetails(
      {super.key,
      required this.name,
      // required this.location,
      required this.rating,
      required this.description,
      required this.imageUrl,
      required this.mapsLink,
      required this.activity,
      required this.latitude,
      required this.longitude});

  Future<void> _launchGoogleMaps(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.resetPageController();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar dengan gambar
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Image Carousel
                  PageView.builder(
                    itemCount: imageUrl.length,
                    controller: controller.pageController,
                    onPageChanged: (index) {
                      controller.setCurrentIndex(index);
                    },
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: imageUrl[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(color: GColors.primary),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      );
                    },
                  ),

                  // Navigation Buttons (only show if more than 1 image)
                  if (imageUrl.length > 1) ...[
                    // Previous Button
                    Positioned(
                      left: 16,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              final currentPage = controller.currentImageIndex;
                              final nextPage = currentPage > 0
                                  ? currentPage - 1
                                  : imageUrl.length - 1;
                              controller.pageController.animateToPage(
                                nextPage,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    // Next Button
                    Positioned(
                      right: 16,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              final currentPage = controller.currentImageIndex;
                              final nextPage = currentPage < imageUrl.length - 1
                                  ? currentPage + 1
                                  : 0;
                              controller.pageController.animateToPage(
                                nextPage,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    // Page Indicator
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: GetBuilder<FavoritesController>(
                        builder: (controller) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              imageUrl.length,
                              (index) => Container(
                                width: 8,
                                height: 8,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.currentImageIndex == index
                                      ? GColors.primary
                                      : Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: GColors.white,
                size: 34,
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: Obx(() {
                  final isFavorite = controller.favorites
                      .any((favorite) => favorite.name == name);
                  return Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: GColors.yellow,
                    size: 34,
                  );
                }),
                onPressed: () {
                  controller.toggleFavorite(
                    name,
                    name,
                    rating,
                    imageUrl,
                    mapsLink,
                    description,
                    activity,
                    latitude,
                    longitude,
                  );
                },
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    name,
                    style: Poppins.bold.copyWith(
                      fontSize: 24,
                      color: GColors.primary,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    'Activity: $activity',
                    style: Poppins.bold.copyWith(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 74, 153, 144),
                    ),
                  ),
                  const Gap(4),
                  GestureDetector(
                    onTap: () => _launchGoogleMaps(mapsLink),
                    child: Text(
                      'Open in Google Maps',
                      style: Poppins.semiBold.copyWith(
                        fontSize: 14,
                        color: GColors.blueDeep,
                        decoration: TextDecoration.underline,
                        decorationColor: GColors.blueDeep,
                      ),
                    ),
                  ),
                  const Gap(24),
                  Text(
                    description,
                    style: Poppins.regular.copyWith(
                      fontSize: 16,
                      color: GColors.darkGrey,
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
