import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constant/constant.dart';
import '../../../../../routes/app_pages.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        height: Get.height * 0.3,
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.BUSINESS);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Get.width * 0.04),
                  decoration: BoxDecoration(
                    color: GColors.backgroundField,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your next\npurchase...",
                        style: Nove.semiBold.copyWith(
                          fontSize: Get.width * 0.05,
                          color: GColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.width * 0.03),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.FAVORITES);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.025,
                    vertical: Get.width * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: GColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Favorites",
                        style: Nove.regular.copyWith(
                          fontSize: Get.width * 0.05,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.star_rounded,
                              color: GColors.yellow,
                              size: MediaQuery.of(context).size.width * 4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
