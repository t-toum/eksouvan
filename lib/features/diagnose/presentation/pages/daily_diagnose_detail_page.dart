import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
import 'package:eksouvan/core/widgets/costom_dropdown.dart';
import 'package:eksouvan/core/widgets/custom_textfield.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/diagnose/presentation/cubit/diagnose_cubit.dart';
import 'package:eksouvan/features/diagnose/presentation/cubit/diagnose_state.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/utils/convert_datas.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/utils/form_builder_validator.dart';
import '../../../../core/widgets/custom_textfield_area.dart';

class DailyDiagnoseDetailPage extends StatelessWidget {
  const DailyDiagnoseDetailPage({
    Key? key,
  }) : super(key: key);
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  cubit.nextPage(currenPage: DiagnosePage.patient);
                },
                child: Text(
                  LocaleKeys.kNext.tr(),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: FormBuilder(
              key: cubit.patientKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(LocaleKeys.kGeneral.tr()),
                  ),
                  //Firstname
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kFirstname,
                    labelText: LocaleKeys.kNameLabel.tr(),
                    initialValue: state.patient?.firstname,
                    enabled: false,
                  ),

                  //Lastname
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kLastname,
                    labelText: LocaleKeys.kLastName.tr(),
                    initialValue: state.patient?.lastname,
                    enabled: false,
                  ),

                  //Gender
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDropdown(
                    labelText: LocaleKeys.kGender.tr(),
                    items: cubit.genderList,
                    name: FieldKeys.kGender,
                    initialValue: state.patient?.gender,
                    enabled: false,
                  ),
                  //BirthDay
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kBirthDay,
                    labelText: LocaleKeys.kDateOfBirth.tr(),
                    initialValue:
                        ConvertDatas.converDateFormat(state.patient?.birthday),
                    enabled: false,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(LocaleKeys.kClinicalData.tr()),
                  ),
                  //Height
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kHeight,
                    labelText: LocaleKeys.KHeight.tr(),
                    hintText: LocaleKeys.kCm.tr(),
                    initialValue: state.patient?.height.toString(),
                    enabled: false,
                  ),
                  //Wieght
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kWeight,
                    labelText:
                        "${LocaleKeys.kWeight.tr()} - ${state.patient?.weight.toString()}",
                    hintText: LocaleKeys.kKg.tr(),
                  ),

                  //Blood Pressure
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kBloodPressure,
                    labelText: LocaleKeys.kBloodPressure.tr(),
                    hintText: LocaleKeys.kBloodPressure.tr(),
                  ),

                  //Temperature
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kTemperature,
                    labelText: LocaleKeys.kTemperature.tr(),
                    hintText: LocaleKeys.kTemperature.tr(),
                  ),

                  //Allergic
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kAllergic,
                    labelText: LocaleKeys.kAllergic.tr(),
                    hintText: LocaleKeys.kAllergic.tr(),
                    isRequired: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: LocaleKeys.kRequiredField.tr(),
                      )
                    ]),
                  ),
                  //Description
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldArea(
                    name: FieldKeys.kDescription,
                    labelText: LocaleKeys.kDescription.tr(),
                    hintText: LocaleKeys.kDescriptionHint.tr(),
                  ),
                  const SizedBox(
                    height: 20,
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
