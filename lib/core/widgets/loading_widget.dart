import 'package:eksouvan/core/utils/constants.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? title;
  final bool showImage;
  const LoadingWidget({Key? key, this.title, this.showImage = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          (showImage == false)
              ? Container()
              : const Expanded(
                  child: Image(
                    image: AssetImage(AppImages.brannerImg),
                    width: 300,
                  ),
                ),
          Expanded(
            child: Column(
              mainAxisAlignment: (showImage == false)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  title ?? '',
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
