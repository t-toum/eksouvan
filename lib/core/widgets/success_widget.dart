import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SuccessWidget extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final String? buttonTile;
  const SuccessWidget({Key? key, this.title, this.onPressed, this.buttonTile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
          onPressed: () {
            AppNavigator.pushAndRemoveUntil(AppRoute.homeRoute);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.done,
            size: 50,
            color: AppColors.primaryColor,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  title ?? 'Succssfully',
                  style: const TextStyle(
                      fontSize: 30,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                (onPressed == null)
                    ? Container()
                    : CusttomButton(
                        onPressed: onPressed,
                        title: buttonTile ?? '',
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
