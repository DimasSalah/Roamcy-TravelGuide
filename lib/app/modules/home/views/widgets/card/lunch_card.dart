import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constant/constant.dart';
import '../../../../restaurants/data/models/restaurant_model.dart';

class LunchCard extends StatelessWidget {
  final MapEntry<RestaurantModel, double> restaurant;
  final Function()? onTap;
  const LunchCard({super.key, required this.restaurant, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        width: Get.width * 0.25,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: GColors.backgroundField,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(restaurant.key.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Poppins.bold
                    .copyWith(fontSize: 12, color: GColors.darkGrey)),
            Text('${restaurant.value} km',
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
                child: CachedNetworkImage(
                  imageUrl: restaurant.key.imageLinks.first,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: GColors.primary,
                    ),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
