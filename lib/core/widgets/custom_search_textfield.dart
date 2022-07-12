import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  const CustomSearchTextField({Key? key,this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusColor: AppColors.primaryColor,
        iconColor: AppColors.primaryColor,
        prefixIcon: const Icon(
          Icons.search,
          size: 40,
        ),
        prefixIconColor: AppColors.primaryColor,
        hintText: tr("kSearch"),
        isDense: true,
        contentPadding: const EdgeInsets.only(top: 8, bottom: 8),
      ),
    );
  }
}
