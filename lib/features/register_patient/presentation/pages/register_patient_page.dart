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
                //Form Input
                FormBuilder(
                  key: cubit.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField(
                          name: 'firstname',
                          labelText: "kNameLabel",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: tr("kRequiredField"))
                          ]),
                        ),
                        CustomTextField(
                          name: 'lastname',
                          labelText: "kLastName",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: tr("kRequiredField"))
                          ]),
                        ),
                        CustomDatePicker(
                          name: "birthday",
                          title: "kDateOfBirth",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: tr("kRequiredField"))
                          ]),
                        ),
                        CustomTextField(
                          name: 'tel',
                          labelText: "kPhone",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: tr("kRequiredField"))
                          ]),
                        ),
                        CustomTextField(
                          name: 'address',
                          labelText: "kCurrentAddress",
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
