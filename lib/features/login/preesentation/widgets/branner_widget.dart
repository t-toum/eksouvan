import 'package:eksouvan/core/utils/constants.dart';
import 'package:flutter/material.dart';

class BrannerWidget extends StatelessWidget {
  const BrannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(top: 50),
      child: const Image(
        image: AssetImage(
          AppImages.brannerImg,
        ),
        width: 500,
      ),
    );
  }
}
