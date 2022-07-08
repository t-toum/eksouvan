import 'package:eksouvan/core/utils/constants.dart';
import 'package:flutter/material.dart';

ThemeData buildTheme() {
  final baseTheme = ThemeData(fontFamily: "NotoSansLao");
  return baseTheme.copyWith(
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(color: AppColors.primaryColor),
    bottomAppBarColor: AppColors.primaryColor,
    primaryColorLight: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColor,
    sliderTheme: SliderThemeData.fromPrimaryColors(
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryColor,
      primaryColorLight: AppColors.primaryColor,
      valueIndicatorTextStyle: const TextStyle(),
    ),
    // textTheme: const TextTheme().copyWith(
    //   headline1: const TextStyle(
    //       color: AppColors.primaryColor,
    //       fontSize: 14,
    //       fontFamily: 'NotoSansLao'),
    // ),
  );
}
