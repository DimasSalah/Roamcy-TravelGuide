import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constant/constant.dart';
import '../../../../../../utils/widgets/button/button_primary.dart';
import '../../../../../routes/app_pages.dart';

class CSettingMenu extends StatelessWidget {
  const CSettingMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final OverlayPortalController tooltipController = OverlayPortalController();
    final link = LayerLink();
    return CompositedTransformTarget(
      link: link,
      child: OverlayPortal(
        controller: tooltipController,
        overlayChildBuilder: (context) => Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => tooltipController.hide(),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            CompositedTransformFollower(
              targetAnchor: Alignment.topLeft,
              link: link,
              offset: Offset(0, 0),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  margin: const EdgeInsets.only(top: 12, left: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                  decoration: BoxDecoration(
                    color: GColors.backgroundField,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: GColors.white,
                        ),
                        child:
                            Icon(Icons.menu, size: 28, color: GColors.primary),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        children: [
                          CircleAvatar(
                            radius: 34,
                            backgroundColor: GColors.primary,
                            child: Icon(Icons.person,
                                size: 56, color: GColors.white),
                          ),
                          Text(
                            auth.currentUser?.displayName ?? '',
                            style: Poppins.bold.copyWith(
                                fontSize: 20, color: GColors.darkGrey),
                          ),
                          ButtonPrimary(
                            color: GColors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            onPressed: () {
                              tooltipController.hide();
                              Get.toNamed(Routes.SETTING);
                            },
                            text: 'Account settings',
                            textStyle: Poppins.bold.copyWith(
                                fontSize: 15, color: GColors.darkGrey),
                            icon: Icon(Icons.settings_outlined,
                                size: 23, color: GColors.primary),
                          ),
                          Gap(14),
                        ],
                      ),
                      Gap(24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        child: GestureDetector(
            onTap: () => tooltipController.show(),
            child: const Icon(Icons.menu, size: 36, color: GColors.primary)),
      ),
    );
  }
}
