import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      title: LocaleKeys.kAddAppointment.tr(),
      body: Container(),
    );
  }
}
