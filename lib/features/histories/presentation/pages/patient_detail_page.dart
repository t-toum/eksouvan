import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
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
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state.dataStatus == DataStatus.loading) {
          return LoadingWidget(
            title: LocaleKeys.kLoginLabel.tr(),
          );
        }
        return AppTemplate(
          title: LocaleKeys.kPatientHistory.tr(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const Image(
                      image: AssetImage(
                        AppImages.default_avatar,
                      ),
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${state.patient?.firstname} ${state.patient?.lastname} ',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(state.patient?.address ?? ''),
                      ],
                    ))
                  ],
                ),
                const Divider(),
                Text('Dianose'),
              ],
            ),
          ),
        );
      },
    );
  }
}
