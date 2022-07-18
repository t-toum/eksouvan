import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
import 'package:eksouvan/core/widgets/custom_textfield.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/diagnose/presentation/cubit/diagnose_cubit.dart';
import 'package:eksouvan/features/diagnose/presentation/cubit/diagnose_state.dart';
import 'package:eksouvan/features/register_patient/domain/entity/patient.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/utils/convert_datas.dart';
import '../../../../core/utils/form_builder_validator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield_area.dart';

class DailyDiagnoseDetailPage extends StatelessWidget {
  final Patient? patient;
  const DailyDiagnoseDetailPage({Key? key, this.patient}) : super(key: key);

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
          title: LocaleKeys.kDiagnoseDetail.tr(),
          body: SingleChildScrollView(
            child: FormBuilder(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date : ${ConvertDatas.converDateFormat(cubit.currentDate)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: 'firstname',
                    labelText: 'kNameLabel',
                    initialValue: patient?.firstname,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: 'lastname',
                    labelText: 'kLastName',
                    initialValue: patient?.lastname,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: 'address',
                    labelText: 'kCurrentAddress',
                    initialValue: patient?.address,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: 'birthday',
                    labelText: 'kDateOfBirth',
                    initialValue:
                        ConvertDatas.converDateFormat(patient?.birthday),
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldArea(
                    name: 'description',
                    labelText: 'kDescription',
                    hintText: "What do you feel to day?",
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: tr("kRequiredField"))
                    ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: CusttomButton(
                      title: 'kNewRegisterLabel',
                      onPressed: () {
                        context
                            .read<DiagnoseCubit>()
                            .addPatientDiagnose(patient: patient);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
