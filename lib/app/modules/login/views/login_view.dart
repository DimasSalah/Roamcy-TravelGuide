import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../../utils/constant/constant.dart';
import '../../../../utils/resources/resources.dart';
import '../../../../utils/widgets/button/button_primary.dart';
import '../../../../utils/widgets/checkbox/checkbox_item.dart';
import '../../../../utils/widgets/textfields/input_password.dart';
import '../../../../utils/widgets/textfields/input_primary.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Unlock A new view of the island today',
                    style: Nove.medium.copyWith(
                      color: GColors.primary,
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Gap(50),
                Text(
                  'Login',
                  style: Poppins.bold.copyWith(
                    fontSize: 24,
                    color: GColors.darkGrey,
                  ),
                ),
                Gap(10),
                InputPrimary(
                  hint: 'example@gmail.com',
                  controller: controller.emailController,
                ),
                Gap(8),
                InputPassword(
                  hint: 'Password',
                  controller: controller.passwordController,
                ),
                Gap(10),
                Obx(() {
                  return CheckboxItem(
                    text: 'Keep me logged in',
                    value: controller.isKeepMeLoggedIn.value,
                    onChanged: (value) {
                      controller.toggleKeepMeLoggedIn();
                    },
                  );
                }),
                GetBuilder<LoginController>(builder: (controller) {
                  return ButtonPrimary(
                    fullWidth: true,
                    text: 'Login',
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      controller.login(
                        formKey: formKey,
                        email: controller.emailController.text,
                        password: controller.passwordController.text,
                      );
                    },
                  );
                }),
                Gap(2),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Poppins.semiBold.copyWith(
                            color: GColors.black,
                            fontSize: 12,
                            decoration: TextDecoration.underline),
                      ),
                      TextSpan(
                          text: 'Sign up here',
                          style: Poppins.semiBold
                              .copyWith(color: GColors.blueDeep, fontSize: 12),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(Routes.SIGNUP);
                            }),
                    ],
                  ),
                ),
                Gap(20),
                // SizedBox(
                //   height: 50,
                //   width: double.infinity,
                //   child: ButtonPrimary(
                //     icon: Icon(Icons.apple, color: GColors.white, size: 25),
                //     text: 'Continue with Apple',
                //     color: GColors.darkGrey,
                //     onPressed: () {},
                //   ),
                // ),
                // Gap(10),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ButtonPrimary(
                    icon: SvgPicture.asset(SVGs.googleColorSvgrepoCom,
                        width: 20, height: 20),
                    text: 'Continue with Google',
                    textStyle: Poppins.medium.copyWith(
                      color: GColors.black,
                      fontSize: 14,
                    ),
                    color: GColors.lightGrey,
                    onPressed: () {
                      controller.loginWithGoogle();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
