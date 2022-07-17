import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/form_builder_validator.dart';
import 'package:eksouvan/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/widgets/app_template.dart';
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
          return const LoadingWidget(
            showImage: false,
            title: 'Saving..',
          );
        }
        return AppTemplate(
          titleKey: "kNewRegisterLabel",
          body: Center(
            child: Column(
              children: [
                FormBuilder(
                  key: cubit.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField(
                          name: 'firstname',
                          labelText: "kNameLabel",
                          hintText: tr('kPatientName'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: tr("kRequiredField"))
                          ]),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          name: 'lastname',
                          labelText: "kLastName",
                          hintText: tr("kPatientLastName"),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: tr("kRequiredField"))
                          ]),
                        ),
                        CustomDatePicker(
                          name: "birthday",
                          title: "kDateOfBirth",
                          hintText: tr("kPatientBirtDay"),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: tr("kRequiredField"))
                          ]),
                        ),
                        CustomTextField(
                          name: 'tel',
                          labelText: "kPhone",
                          hintText: tr("kPhoneNumber"),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: tr("kRequiredField"))
                          ]),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          name: 'address',
                          labelText: "kCurrentAddress",
                          hintText: tr("kCurrentAddress"),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: tr("kRequiredField"))
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CusttomButton(
                          title: 'kNewRegisterLabel',
                          onPressed: () {
                            context
                                .read<RegisterPatientCubit>()
                                .addNewPatient();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
