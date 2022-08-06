import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/dropdown_item.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/core/widgets/costom_dropdown.dart';
import 'package:eksouvan/core/widgets/custom_date_picker.dart';
import 'package:eksouvan/core/widgets/custom_textfield_area.dart';
import 'package:eksouvan/core/widgets/failure_widget.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/appointments/presentation/cubit/appointment_cubit.dart';
import 'package:eksouvan/features/appointments/presentation/widgets/patient_modal.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/utils/form_builder_validator.dart';
import '../cubit/appointment_state.dart';

class AddAppointmentWidget extends StatefulWidget {
  const AddAppointmentWidget({Key? key}) : super(key: key);

  @override
  State<AddAppointmentWidget> createState() => _AddAppointmentWidgetState();
}

class _AddAppointmentWidgetState extends State<AddAppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppointmentCubit>();
    return Scaffold(
      body: BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
          if (state.dataStatus == DataStatus.loading) {
            return const LoadingWidget(
              showImage: false,
            );
          } else if (state.dataStatus == DataStatus.failure) {
            return FailureWidget(
              errorMessage: state.error,
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      AppNavigator.goBack();
                    },
                    child: Text(
                      LocaleKeys.kCancel.tr(),
                      style: const TextStyle(
                          color: AppColors.primaryColor, fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cubit.addAppointment();
                    },
                    child: Text(
                      LocaleKeys.kSave.tr(),
                      style: const TextStyle(
                          color: AppColors.primaryColor, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                  child: SingleChildScrollView(
                child: FormBuilder(
                  key: cubit.formKey,
                  child: Column(children: [
                    CustomDropdown(
                      initialValue: cubit.selectedPatientId,
                      items: state.listPatient
                              ?.map((e) => DropdwonItems(
                                  id: e.patientId,
                                  name: "${e.firstname} ${e.lastname}"))
                              .toList() ??
                          [],
                      name: FieldKeys.kPatientId,
                      labelText: LocaleKeys.kPatinet.tr(),
                      isRequired: true,
                      enabled: false,
                      hintText: LocaleKeys.kSelectPaient.tr(),
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          expand: true,
                          enableDrag: false,
                          context: context,
                          builder: (_) {
                            return BlocProvider<AppointmentCubit>.value(
                              value: context.read<AppointmentCubit>(),
                              child: PatientModal(
                                delegate: (value) {
                                  setState(() {
                                    cubit.getAllPatient();
                                    cubit.onChangeValue(value: value);
                                  });
                                },
                              ),
                            );
                          },
                        );
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: LocaleKeys.kRequiredField.tr(),
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomDatePicker(
                      title: LocaleKeys.kDueDate.tr(),
                      name: 'dueDate',
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      hintText: LocaleKeys.kSelectDueDate.tr(),
                      isRequired: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: LocaleKeys.kRequiredField.tr(),
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFieldArea(
                      labelText: LocaleKeys.kDescription.tr(),
                      name: FieldKeys.kDescription,
                    )
                  ]),
                ),
              ))
            ]),
          );
        },
      ),
    );
  }
}
