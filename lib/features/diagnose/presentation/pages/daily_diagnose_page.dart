import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/features/diagnose/presentation/widgets/list_patient_item.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/convert_datas.dart';
import '../../../../core/widgets/app_template.dart';
import '../../../../core/widgets/custom_search_textfield.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../cubit/diagnose_cubit.dart';
import '../cubit/diagnose_state.dart';

class DialyDiagnosePage extends StatelessWidget {
  const DialyDiagnosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DiagnoseCubit>();
    return BlocBuilder<DiagnoseCubit, DiagnoseState>(
      builder: (context, state) {
        if (state.dataStatus == DataStatus.loading) {
          return const LoadingWidget(
            showImage: false,
          );
        }
        return AppTemplate(
          title: LocaleKeys.kDailyDiagnoseLabel.tr(),
          body: Column(
            children: [
              CustomSearchTextField(
                controller: cubit.searchController,
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
                        tel: state.listPatient?[index].tel,
                        address: state.listPatient?[index].address,
                        lastUpdate: ConvertDatas.converDateFormat(
                            state.listPatient?[index].updateDate),
                        onTap: () {
                          AppNavigator.navigateTo(
                            AppRoute.dialyDiagnoseDetailRoute,
                            params: state.listPatient?[index].patientId,
                          );
                        },
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
