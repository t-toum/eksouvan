import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class ModalAppointmentWidget extends StatelessWidget {
  const ModalAppointmentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      AppNavigator.goBack();
                    },
                    child: Text(
                      LocaleKeys.kCancel.tr(),
                      style: const TextStyle(
                          fontSize: 20, color: AppColors.primaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      AppNavigator.goBack();
                    },
                    child: Text(
                      LocaleKeys.kOk.tr(),
                      style: const TextStyle(
                          fontSize: 20, color: AppColors.primaryColor),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
