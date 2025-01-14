import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:travel_guide/utils/widgets/button/button_primary.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/constant/constant.dart';
import '../data/model/business_model.dart';
import '../../../../utils/resources/resources.dart';

class BusinessDetailView extends StatelessWidget {
  final BusinessModel business;
  const BusinessDetailView({super.key, required this.business});

  Future<void> _launchInstagram(String url) async {
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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar dengan gambar
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                business.imageLink,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  );
                },
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
                icon: const Icon(
                  Icons.star_border,
                  color: GColors.yellow,
                  size: 34,
                ),
                onPressed: () {
                  // TODO: Implement favorite functionality
                  Get.snackbar(
                    'Favorite',
                    'Added to favorites',
                    snackPosition: SnackPosition.TOP,
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
                    business.name,
                    style: Poppins.bold.copyWith(
                      fontSize: 24,
                      color: GColors.primary,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    'Activity: Shopping',
                    style: Poppins.bold.copyWith(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 74, 153, 144),
                    ),
                  ),
                  const Gap(4),
                  GestureDetector(
                    onTap: () => _launchInstagram(business.link),
                    child: Text(
                      'Open in Instagram',
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
                    business.description,
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
