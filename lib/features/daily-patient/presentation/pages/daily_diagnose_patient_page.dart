import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/daily_patient_cubit.dart';
import '../cubit/daily_patient_state.dart';

class DailyDiagnosePatientPage extends StatelessWidget {
  const DailyDiagnosePatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      title: LocaleKeys.kDiagnosePatient.tr(),
      body: BlocBuilder<DailyPatientCubit, DailyPatientState>(
        builder: ((context, state) {
          if (state.dataStatus == DataStatus.loading) {
            return const LoadingWidget(
              showImage: false,
            );
          }
          return Container(
            child: Text(state.patient?.firstname ?? ''),
          );
        }),
      ),
    );
  }
}
