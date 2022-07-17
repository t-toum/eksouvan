import 'package:eksouvan/core/utils/constants.dart';
import 'package:flutter/material.dart';

import '../utils/app_navigator.dart';

class WidgetBuilders {
  static AppBar customAppbar({VoidCallback? onPressed}) {
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
      actions: [
        (onPressed != null)
            ? IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.logout, size: 30),
              )
            : Container(),
      ],
    );
  }

  static customDialog(
      {required BuildContext context,
      required String title,
      required String content}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(color: Colors.red),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(content),
            ),
            actions: [
              TextButton(
                  onPressed: () => AppNavigator.goBack(),
                  child: const Text('OK'))
            ],
            //actionsAlignment: MainAxisAlignment.center,
          );
        });
  }
}
