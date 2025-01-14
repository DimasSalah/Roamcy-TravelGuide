import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/constant.dart';

class GAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios_new, color: GColors.primary),
      ),
      title: Text(title,
          style: Nove.semiBold.copyWith(fontSize: 20, color: GColors.primary)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}