import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travel_guide/utils/widgets/textfields/input_password.dart';
import 'package:travel_guide/utils/widgets/textfields/input_primary.dart';
import '../../../../utils/constant/constant.dart';
import '../../../../utils/helper/form_validation.dart';
import '../../../../utils/resources/resources.dart';
import '../../../../utils/widgets/button/button_primary.dart';
import '../../../../utils/widgets/checkbox/checkbox_item.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                  'Sign Up',
                  style: Poppins.bold.copyWith(
                    fontSize: 24,
                    color: GColors.darkGrey,
                  ),
                ),
                Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: InputPrimary(
                        hint: 'First Name',
                        controller: controller.firstName,
                        validation: FormValidation.validateNotEmpty,
                      ),
                    ),
                    Gap(8),
                    Expanded(
                      child: InputPrimary(
                        hint: 'Surname',
                        controller: controller.surName,
                      ),
                    )
                  ],
                ),
                Gap(8),
                InputPrimary(
                  hint: 'example@gmail.com',
                  controller: controller.email,
                  validation: FormValidation.validateEmail,
                ),
                Gap(8),
                InputPassword(
                  hint: 'Password',
                  controller: controller.password,
                  validation: FormValidation.validatePassword6Char,
                ),
                Gap(8),
                InputPassword(
                  hint: 'Confirm Password',
                  controller: controller.confirmPassword,
                ),
                Gap(10),
                Obx(() {
                  return CheckboxItem(
                    text: 'The user signing up is 18 or over',
                    value: controller.rule1.value,
                    onChanged: (value) {
                      controller.toggleRule1();
                    },
                  );
                }),
                Obx(() {
                  return CheckboxItem(
                    text: 'The user complies with the Terms and Conditions',
                    value: controller.rule2.value,
                    onChanged: (value) {
                      controller.toggleRule2();
                    },
                  );
                }),
                GetBuilder<SignupController>(builder: (controller) {
                  return ButtonPrimary(
                    fullWidth: true,
                    text: 'Create Account',
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      controller.signup(
                        formKey: formKey,
                        firstName: controller.firstName.text,
                        surName: controller.surName.text,
                        email: controller.email.text,
                        password: controller.password.text,
                        confirmPassword: controller.confirmPassword.text,
                      );
                    },
                  );
                }),
                Gap(2),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: Poppins.semiBold.copyWith(
                            color: GColors.black,
                            fontSize: 12,
                            decoration: TextDecoration.underline),
                      ),
                      TextSpan(
                          text: 'Login here',
                          style: Poppins.semiBold
                              .copyWith(color: GColors.blueDeep, fontSize: 12),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(Routes.LOGIN);
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
                //     onPressed: () {
                //       controller.signupWithApple();
                //     },
                //   ),
                // ),
                // Gap(10),
                ButtonPrimary(
                  fullWidth: true,
                  icon: SvgPicture.asset(SVGs.googleColorSvgrepoCom,
                      width: 20, height: 20),
                  text: 'Continue with Google',
                  textStyle: Poppins.medium.copyWith(
                    color: GColors.black,
                    fontSize: 14,
                  ),
                  color: GColors.lightGrey,
                  onPressed: () {
                    controller.signupWithGoogle();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
