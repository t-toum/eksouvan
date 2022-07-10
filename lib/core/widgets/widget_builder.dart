import 'package:eksouvan/core/utils/constants.dart';
import 'package:flutter/material.dart';

class WidgetBuilders {
  static AppBar customAppbar() {
    return AppBar(
      toolbarHeight: 100,
      centerTitle: true,
      title: Container(
        height: 100,
        width: double.infinity,
        color: AppColors.primaryColor,
        child: const Image(
          image: AssetImage(AppImages.branner_outline),
        ),
      ),
    );
  }
}
