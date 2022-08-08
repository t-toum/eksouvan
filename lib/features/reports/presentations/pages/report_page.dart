import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../widgets/report_item.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      title: LocaleKeys.kReport.tr(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ReporItem(
              label: LocaleKeys.kReportPatient.tr(),
              onTap: () {
                AppNavigator.navigateTo(AppRoute.reportPatientRoute);
              },
            ),
            ReporItem(
              label: LocaleKeys.kReportDiagnose.tr(),
              onTap: () {
                AppNavigator.navigateTo(AppRoute.reportDiagnoseRoute);
              },
            ),
            ReporItem(
              label: LocaleKeys.kReportAppointment.tr(),
              onTap: () {
                AppNavigator.navigateTo(AppRoute.reportAppointmentRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
