import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/dropdown_item.dart';
import 'package:eksouvan/core/utils/form_builder_validator.dart';
import 'package:eksouvan/core/widgets/custom_textfield.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/utils/field_keys.dart';
import '../../../../core/widgets/app_template.dart';
import '../../../../core/widgets/costom_dropdown.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_date_picker.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../cubit/register_patient_cubit.dart';
import '../cubit/register_patient_state.dart';

class RegisterPatientPage extends StatelessWidget {
  const RegisterPatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterPatientCubit>();
    return BlocBuilder<RegisterPatientCubit, RegisterPatientState>(
      builder: (context, state) {
        if (state.dataStatus == DataStatus.loading) {
          return LoadingWidget(
            showImage: false,
            title: LocaleKeys.kSaving.tr(),
          );
        }
        return AppTemplate(
          title: LocaleKeys.kNewRegisterLabel.tr(),
          body: FormBuilder(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    name: FieldKeys.kFirstname,
                    isRequired: true,
                    labelText: LocaleKeys.kNameLabel.tr(),
                    hintText: LocaleKeys.kPatientName.tr(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: LocaleKeys.kRequiredField.tr(),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kLastname,
                    isRequired: true,
                    labelText: LocaleKeys.kLastName.tr(),
                    hintText: LocaleKeys.kPatientLastName.tr(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: LocaleKeys.kRequiredField.tr(),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDropdown(
                    name: FieldKeys.kGender,
                    items: cubit.genderList,
                    isRequired: true,
                    labelText: LocaleKeys.kGender.tr(),
                    hintText: LocaleKeys.kSelectGender.tr(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: LocaleKeys.kRequiredField.tr(),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDatePicker(
                    name: FieldKeys.kBirthDay,
                    isRequired: true,
                    title: LocaleKeys.kDateOfBirth.tr(),
                    hintText: LocaleKeys.kPatientBirtDay.tr(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: LocaleKeys.kRequiredField.tr(),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kWeight,
                    labelText: LocaleKeys.kWeight.tr(),
                    hintText: LocaleKeys.kKg.tr(),
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kHeight,
                    labelText: LocaleKeys.KHeight.tr(),
                    hintText: LocaleKeys.kCm.tr(),
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kCongenitalDeases,
                    labelText: LocaleKeys.kCongenitalDeases.tr(),
                    hintText: LocaleKeys.kCongenitalDeases.tr(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: FieldKeys.kTel,
                    isRequired: true,
                    labelText: LocaleKeys.kPhone.tr(),
                    hintText: LocaleKeys.kPhoneNumber.tr(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: LocaleKeys.kRequiredField.tr(),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    isRequired: true,
                    name: FieldKeys.kAddress,
                    labelText: LocaleKeys.kCurrentAddress.tr(),
                    hintText: LocaleKeys.kCurrentAddress.tr(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: LocaleKeys.kRequiredField.tr(),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CusttomButton(
                    title: LocaleKeys.kNewRegisterLabel.tr(),
                    onPressed: () {
                      context.read<RegisterPatientCubit>().addNewPatient();
                    },
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
