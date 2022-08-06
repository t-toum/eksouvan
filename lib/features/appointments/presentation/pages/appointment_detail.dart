import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';

class AppointDetailPage extends StatelessWidget {
  const AppointDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      title: LocaleKeys.kAppointmentDetail.tr(),
      body: Container(),
    );
  }
}
