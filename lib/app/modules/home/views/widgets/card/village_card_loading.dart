import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constant/constant.dart';
import '../../../../village/data/model/village_model.dart';

class VillageCardLoading extends StatelessWidget {
  const VillageCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: EdgeInsets.all(Get.width * 0.04),
      decoration: BoxDecoration(
        color: GColors.orangeAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's Next?",
            style: Nove.semiBold.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              color: Colors.white,
            ),
          ),
          Text(
            'Loading...',
            style: Poppins.regular.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: Colors.white,
            ),
          ),
          Text(
            "0 km",
            style: Poppins.semiBold.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: Colors.white,
            ),
          ),
          const Gap(10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/logo.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
