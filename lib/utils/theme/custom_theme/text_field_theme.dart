import 'package:flutter/material.dart';
import '../../constant/constant.dart';


class GTextFormFieldTheme {
  GTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: GColors.darkGrey,
    suffixIconColor: GColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: GSizes.inputFieldHeight),
    labelStyle: const TextStyle()
        .copyWith(fontSize: Poppins.regular.fontSize, color: GColors.black),
    hintStyle: const TextStyle()
        .copyWith(fontSize: Poppins.regular.fontSize, color: GColors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: GColors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: GColors.backgroundField),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: GColors.backgroundField),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: GColors.backgroundField),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 2, color: Colors.red),
    ),
  );

  // static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  //   errorMaxLines: 2,
  //   prefixIconColor: GColors.darkbackgroundField,
  //   suffixIconColor: GColors.darkGrey,
  //   // constraints: const BoxConstraints.expand(height: GSizes.inputFieldHeight),
  //   labelStyle: const TextStyle()
  //       .copyWith(fontSize: GSizes.fontSizeMd, color: GColors.white),
  //   hintStyle: const TextStyle()
  //       .copyWith(fontSize: GSizes.fontSizeSm, color: GColors.white),
  //   floatingLabelStyle:
  //       const TextStyle().copyWith(color: GColors.white.withOpacity(0.8)),
  //   border: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(GSizes.inputFieldRadius),
  //     borderSide: const BorderSide(width: 1, color: GColors.darkGrey),
  //   ),
  //   enabledBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(GSizes.inputFieldRadius),
  //     borderSide: const BorderSide(width: 1, color: GColors.darkGrey),
  //   ),
  //   focusedBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(GSizes.inputFieldRadius),
  //     borderSide: const BorderSide(width: 1, color: GColors.white),
  //   ),
  //   errorBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(GSizes.inputFieldRadius),
  //     borderSide: const BorderSide(width: 1, color: GColors.warning),
  //   ),
  //   focusedErrorBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(GSizes.inputFieldRadius),
  //     borderSide: const BorderSide(width: 2, color: GColors.warning),
  //   ),
  // );
}
