import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
import 'package:eksouvan/core/widgets/custom_search_textfield.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/daily_patient_cubit.dart';
import '../cubit/daily_patient_state.dart';
import '../widgets/list_patient_item.dart';

class DailyPatientPage extends StatelessWidget {
  const DailyPatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DailyPatientCubit>();
    return AppTemplate(
      title: LocaleKeys.kDailyPatient.tr(),
      body: BlocBuilder<DailyPatientCubit, DailyPatientState>(
        builder: (context, state) {
          if (state.dataStatus == DataStatus.loading) {
            return const Scaffold(
              body: LoadingWidget(showImage: false),
            );
          }
          return Column(
            children: [
              CustomSearchTextField(
                controller: cubit.searchTextController,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        List.generate(state.listPatient?.length ?? 0, (index) {
                      return ListPatientItem(
                        firstname: state.listPatient?[index].firstname,
                        lastname: state.listPatient?[index].lastname,
                        address: state.listPatient?[index].address,
                        lastUpdate: state.listPatient?[index].lastUpdate,
                        onTap: () {
                          AppNavigator.navigateTo(
                              AppRoute.dialyDiagnoseDetailRoute,
                              params: state.listPatient?[index].patientId);
                        },
                      );
                    }),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
