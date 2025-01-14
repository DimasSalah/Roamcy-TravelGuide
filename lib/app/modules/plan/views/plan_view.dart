import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utils/constant/constant.dart';
import '../controllers/plan_controller.dart';

class PlanView extends GetView<PlanController> {
  const PlanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personalize Your Trip',
            style: Poppins.semiBold
                .copyWith(fontSize: 20, color: GColors.darkGrey)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      controller.questions.length,
                      (index) => Expanded(
                        child: Container(
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: index <= controller.currentPage.value
                                ? GColors.primary
                                : GColors.lightGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Question ${controller.currentPage.value + 1} of ${controller.questions.length}',
                    style: Poppins.medium.copyWith(
                      color: GColors.darkGrey,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            }),
          ),

          // Questions PageView
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              physics:
                  const NeverScrollableScrollPhysics(), // Disable manual swipe
              itemCount: controller.questions.length,
              onPageChanged: (index) => controller.currentPage.value = index,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.questions[index],
                        style: Poppins.semiBold.copyWith(
                          fontSize: 24,
                          color: GColors.darkGrey,
                        ),
                      ),
                      Gap(32),
                      Center(
                        child: SvgPicture.asset(
                          controller.imageQuestion[index],
                          width: Get.width * 0.7,
                        ),
                      ),
                      Gap(30),
                      // Example answer buttons - customize based on your needs
                      Expanded(
                        child: ListView.separated(
                          itemCount: controller.answers[index].length,
                          separatorBuilder: (context, i) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, i) {
                            return _AnswerButton(
                              text: controller.answers[index][i],
                              onTap: () => controller
                                  .nextPage(controller.answers[index][i]),
                              isSelected:
                                  controller.selectedAnswers.length > index &&
                                      controller.selectedAnswers[index] ==
                                          controller.answers[index][i],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isSelected;

  const _AnswerButton({
    required this.text,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? GColors.primary.withOpacity(0.1)
              : Colors.transparent,
          border: Border.all(
            color: GColors.darkGrey.withOpacity(0.2),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: Poppins.medium.copyWith(
            fontSize: 16,
            color: isSelected ? GColors.primary : GColors.darkGrey,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
