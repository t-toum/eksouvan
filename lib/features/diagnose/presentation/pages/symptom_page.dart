import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/core/utils/form_builder_validator.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
import 'package:eksouvan/core/widgets/custom_checkbox.dart';
import 'package:eksouvan/core/widgets/custom_textfield.dart';
import 'package:eksouvan/core/widgets/custom_textfield_area.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/diagnose/presentation/cubit/diagnose_cubit.dart';
import 'package:eksouvan/features/diagnose/presentation/cubit/diagnose_state.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SymptomPage extends StatelessWidget {
  const SymptomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DiagnoseCubit>();

    return AppTemplate(
      title: LocaleKeys.KSymptom.tr(),
      actions: [
        TextButton(
          onPressed: () {
            AppNavigator.navigateTo(AppRoute.medicineRoute);
          },
          child: Text(
            LocaleKeys.kNext.tr(),
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
      body: BlocBuilder<DiagnoseCubit, DiagnoseState>(
        builder: (context, state) {
          if (state.dataStatus == DataStatus.loading) {
            return const LoadingWidget(
              showImage: false,
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: List.generate(state.listDeases?.length ?? 0, (index) {
                  return CustomCheckBox(
                    name: 'deases',
                    decoration: const InputDecoration(
                      isDense: true,
                    ),
                    title: Text(
                      state.listDeases?[index].deases ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(state.listDeases?[index].description ?? ''),
                    onChanged: (val) {
                      if (val == true) {
                        cubit.listDeases.add(state.listDeases?[index]);
                      } else {
                        cubit.listDeases.removeAt(index);
                      }
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 15,
              ),
              (state.error != null)
                  ? Row(
                      children: [
                        Text(
                          "Warning: ${state.error}",
                          style:
                              const TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primaryColor),
                      ),
                      child: Text(
                        LocaleKeys.kAddNew.tr(),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          expand: true,
                          barrierColor: Colors.transparent,
                          enableDrag: false,
                          bounce: true,
                          builder: (context) => Scaffold(
                            body: FormBuilder(
                              key: cubit.desaesKey,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            AppNavigator.goBack();
                                          },
                                          child: Text(
                                            LocaleKeys.kCancel.tr(),
                                            style: const TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 20),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            cubit.saveDeases();
                                          },
                                          child: Text(
                                            LocaleKeys.kSave.tr(),
                                            style: const TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 21),
                                          ),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                        child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          CustomTextField(
                                            name: FieldKeys.kDeases,
                                            labelText: LocaleKeys.kDeases.tr(),
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(
                                                errorText: LocaleKeys
                                                    .kRequiredField
                                                    .tr(),
                                              )
                                            ]),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          CustomTextFieldArea(
                                            name: FieldKeys.kDescription,
                                            labelText:
                                                LocaleKeys.kDescription.tr(),
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(
                                                errorText: LocaleKeys
                                                    .kRequiredField
                                                    .tr(),
                                              )
                                            ]),
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}