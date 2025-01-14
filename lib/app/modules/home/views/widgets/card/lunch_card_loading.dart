import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../utils/constant/constant.dart';

class LunchCardLoading extends StatelessWidget {
  const LunchCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Loading...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  Poppins.bold.copyWith(fontSize: 12, color: GColors.darkGrey)),
          Text('0 km',
              style: Poppins.regular
                  .copyWith(fontSize: 12, color: GColors.darkGrey)),
          Gap(4),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: GColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
