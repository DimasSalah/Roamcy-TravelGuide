import 'package:flutter/material.dart';
import 'package:travel_guide/utils/constant/constant.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      disabledColor: GColors.lightGrey,
      brightness: Brightness.light,
      primaryColor: GColors.blueSky,
      scaffoldBackgroundColor: GColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: GColors.background,
      )
      // appBarTheme: GAppBarTheme.darkAppBarTheme.copyWith(
      //   systemOverlayStyle: const SystemUiOverlayStyle(
      //     statusBarColor: Colors.transparent,
      //     statusBarIconBrightness: Brightness.light,
      //     statusBarBrightness: Brightness.dark,
      //   ),
      // ),
      // checkboxTheme: GCheckboxTheme.darkCheckboxTheme,
      // bottomSheetTheme: GBottomSheetTheme.darkBottomSheetTheme,
      // elevatedButtonTheme: GElevatedButtonTheme.darkElevatedButtonTheme,
      // outlinedButtonTheme: GOutlinedButtonTheme.darkOutlinedButtonTheme,
      // inputDecorationTheme: GTextFormFieldTheme.darkInputDecorationTheme,
      );
}
