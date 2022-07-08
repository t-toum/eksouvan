import 'package:eksouvan/core/utils/constants.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? title;
  const LoadingWidget({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Image(
            image: AssetImage(AppImages.brannerImg),
            width: 300,
          ),
        ),
        Expanded(
            child: Column(
          children: [
            const CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              title ?? '',
              style: const TextStyle(fontSize: 20, color: Colors.black),
            )
          ],
        ))
      ],
    ));
  }
}
