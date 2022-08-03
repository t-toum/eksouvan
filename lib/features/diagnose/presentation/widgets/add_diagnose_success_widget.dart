import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class AddDiagnoseSuccessWidget extends StatelessWidget {
  final String patientId;
  const AddDiagnoseSuccessWidget({Key? key, required this.patientId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          child: const Icon(
            Icons.close,
            color: Colors.red,
          ),
          onTap: () {
            AppNavigator.pushAndRemoveUntil(AppRoute.homeRoute);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(AppImages.success),
              width: 50,
              height: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(LocaleKeys.kSaveSuccess.tr()),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                AppNavigator.navigateTo(AppRoute.appointmentRout);
              },
              child: Text(
                LocaleKeys.kAddAppointment.tr(),
                style: const TextStyle(color: AppColors.primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
