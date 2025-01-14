import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utils/constant/constant.dart';
import '../../../../utils/resources/resources.dart';
import '../../../../utils/widgets/button/button_primary.dart';
import '../../../base/services/authentication_services.dart';
import '../../../routes/app_pages.dart';
import '../controllers/setting_controller.dart';
import 'widgets/change_password_dialog.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Account Settings',
                  style:
                      Nove.bold.copyWith(fontSize: 20, color: GColors.darkGrey),
                ),
                Container(
                  width: Get.width * 0.5,
                  height: Get.width * 0.5,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: GColors.backgroundField,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: GColors.primary,
                        child: Icon(
                          Icons.person,
                          size: 62,
                          color: GColors.white,
                        ),
                      ),
                      Gap(17),
                      Obx(
                        () => Text(
                          '${controller.userModel.value.firstName} ${controller.userModel.value.surName}',
                          style: Poppins.bold
                              .copyWith(fontSize: 22, color: GColors.darkGrey),
                        ),
                      )
                    ],
                  ),
                ),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ButtonPrimary(
                        text: 'Edit Username',
                        icon: Icon(
                          Icons.edit_outlined,
                          size: 20,
                          color: GColors.darkGrey,
                        ),
                        textStyle: Poppins.bold
                            .copyWith(fontSize: 13, color: GColors.darkGrey),
                        color: GColors.backgroundField,
                        onPressed: controller.showEditUsernameDialog,
                      ),
                    ),
                    // Gap(10),
                    // Expanded(
                    //   child: ButtonPrimary(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10),
                    //     text: 'Edit Picture',
                    //     icon: Icon(
                    //       Icons.person,
                    //       size: 20,
                    //       color: GColors.darkGrey,
                    //     ),
                    //     textStyle: Poppins.bold
                    //         .copyWith(fontSize: 13, color: GColors.darkGrey),
                    //     color: GColors.backgroundField,
                    //     onPressed: () {},
                    //   ),
                    // ),
                  ],
                ),
                Gap(10),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: GColors.backgroundField,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email : ',
                        style: Poppins.bold.copyWith(fontSize: 14),
                      ),
                      Text(
                        auth.currentUser?.email ?? '',
                        style: Poppins.bold.copyWith(fontSize: 14),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                Gap(10),
                auth.currentUser?.providerData.first.providerId == 'apple.com'
                    ? ButtonPrimary(
                        icon: Icon(Icons.apple, color: GColors.white, size: 25),
                        text: 'Apple',
                        color: GColors.darkGrey,
                        onPressed: () {},
                      )
                    : auth.currentUser?.providerData.first.providerId ==
                            'google.com'
                        ? ButtonPrimary(
                            fullWidth: true,
                            icon: SvgPicture.asset(SVGs.googleColorSvgrepoCom,
                                width: 20, height: 20),
                            text: 'Google',
                            textStyle: Poppins.semiBold.copyWith(
                              color: GColors.black,
                              fontSize: 16,
                            ),
                            color: GColors.lightGrey,
                            onPressed: () {},
                          )
                        : SizedBox(),
                auth.currentUser?.providerData.first.providerId == 'password'
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: GColors.backgroundField,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Password : ',
                              style: Poppins.bold.copyWith(fontSize: 14),
                            ),
                            Text(
                              '**********',
                              style: Poppins.bold.copyWith(fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.dialog(const ChangePasswordDialog());
                              },
                              child: Text(
                                'Change Password?',
                                style: Poppins.bold.copyWith(
                                    fontSize: 8, color: GColors.blueDeep),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Gap(30),
                ButtonPrimary(
                  fullWidth: true,
                  text: 'Our Terms and Conditions',
                  onPressed: () {},
                ),
                ButtonPrimary(
                  fullWidth: true,
                  text: 'Logout',
                  color: Colors.red,
                  onPressed: () {
                    final AuthenticationServices authenticationServices =
                        AuthenticationServices();
                    authenticationServices.logout();
                    Get.offAllNamed(Routes.LOGIN);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
