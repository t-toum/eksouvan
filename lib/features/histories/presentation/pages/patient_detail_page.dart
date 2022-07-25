import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/features/histories/presentation/cubit/history_cubit.dart';
import 'package:eksouvan/features/histories/presentation/cubit/history_state..dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_template.dart';
import '../../../../generated/locale_keys.g.dart';

class PatientDetailPage extends StatelessWidget {
  const PatientDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      title:LocaleKeys.kPatientHistory.tr(),
      body: BlocBuilder<HistoryCubit,HistoryState>(
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
