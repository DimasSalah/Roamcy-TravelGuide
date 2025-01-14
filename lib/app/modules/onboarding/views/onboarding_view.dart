import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../../utils/constant/constant.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/resources/resources.dart';
import '../../../../utils/widgets/button/button_primary.dart';
import '../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.selectedPageIndex,
            children: [
              OnboardingPage(
                title: 'Discover the hidden gems of the Island',

                image: SVGs.onboarding1, // Sesuaikan dengan asset Anda
              ),
              OnboardingPage(
                title: 'Create your very own perosnalized tour plan',
                image: SVGs.onboarding2,
              ),
              OnboardingPage(
                title: 'Make the Most out of your trip to Cyprus',
                image: SVGs.onboarding3,
              ),
            ],
          ),

          // Skip button
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () => controller.skipToEnd(),
              child: Column(
                children: [
                  Text(
                    'Skip',
                    style: Poppins.bold.copyWith(
                      fontSize: 16,
                      color: GColors.blueSky,
                    ),
                  ),
                  Icon(
                    size: 1.4,
                    Icons.arrow_forward,
                    color: GColors.blueSky,
                  ),
                ],
              ),
            ),
          ),

          // Dot indicators
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Obx(() {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.selectedPageIndex.value == index
                                  ? Colors.blue
                                  : Colors.grey[300],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                Gap(20),
                SizedBox(
                  width: Get.width * 0.6,
                  child: ButtonPrimary(
                    borderRadius: 30,
                    onPressed: () {
                      if (controller.isLastPage) {
                        Get.offAllNamed(Routes.LOGIN);
                        GLocalStorage().saveData('onboarding', true);
                      } else {
                        controller.nextPage();
                      }
                    },
                    text: 'Continue',
                    textStyle: Poppins.bold.copyWith(
                      fontSize: 15,
                      color: GColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String image;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Nove.regular.copyWith(
              fontSize: 25,
              color: GColors.primary,
            ),
            textAlign: TextAlign.start,
          ),
          SvgPicture.asset(
            image,
            height: 250,
          ),
        ],
      ),
    );
  }
}
