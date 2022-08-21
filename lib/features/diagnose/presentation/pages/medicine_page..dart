import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/entities/medicine.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/form_builder_validator.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
import 'package:eksouvan/core/widgets/custom_textfield_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/usecases/next_page_params.dart';
import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/dropdown_item.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/utils/field_keys.dart';
import '../../../../core/widgets/costom_dropdown.dart';
import '../../../../core/widgets/custom_checkbox.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubit/diagnose_cubit.dart';
import '../cubit/diagnose_state.dart';

class MedicinePage extends StatelessWidget {
  const MedicinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DiagnoseCubit>();
    return AppTemplate(
      title: LocaleKeys.kMedicine.tr(),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              cubit.nextPage(
                  nextPageParams: NextPageParams(
                      diagnosePage: DiagnosePage.medicine, cubit: cubit));
            },
            child: Text(
              LocaleKeys.kNext.tr(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ],
      body: BlocConsumer<DiagnoseCubit, DiagnoseState>(
        listener: (context, state) {
          if (state.dataStatus == DataStatus.saveMedicineSucess) {
            AppNavigator.goBack();
            cubit.getAllMedicine();
          }
        },
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
                children:
                    List.generate(state.listMedicine?.length ?? 0, (index) {
                  return CustomCheckBox(
                    name: 'medicines',
                    decoration: const InputDecoration(
                      isDense: true,
                    ),
                    initialValue: cubit.formValue['medicines'] == null
                        ? false
                        : (cubit.formValue['medicines'] as List<Medicine?>)
                            .contains(state.listMedicine?[index]),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            state.listMedicine?[index].medicine ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            cubit.getMedicineTypeName(
                                id: state.listMedicine?[index].type ?? ''),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    subtitle:
                        Text(state.listMedicine?[index].description ?? ''),
                    onChanged: (val) {
                      if (val == true) {
                        if (!cubit.listMedicine
                            .contains(state.listMedicine?[index])) {
                          cubit.listMedicine.add(state.listMedicine?[index]);
                        }
                      } else {
                        cubit.listMedicine.removeWhere((el) =>
                            el?.docId == state.listMedicine?[index].docId);
                      }
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 15,
              ),
              (state.dataStatus == DataStatus.failure && state.error != null)
                  ? Row(
                      children: [
                        Text(
                          "${LocaleKeys.kwarning.tr()}: ${state.error}",
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
                              key: cubit.medicineKey,
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
                                            cubit.addNewMedicine();
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
                                            isRequired: true,
                                            name: 'medicine',
                                            labelText:
                                                LocaleKeys.kMedicine.tr(),
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
                                          CustomDropdown(
                                            isRequired: true,
                                            // initialValue: cubit.pickedMedicine,
                                            labelText:
                                                LocaleKeys.kMedicineType.tr(),
                                            hintText: LocaleKeys
                                                .kSelectMedicineType
                                                .tr(),
                                            items: cubit.listMedicineType
                                                    ?.map((type) =>
                                                        DropdwonItems(
                                                            id: type.id,
                                                            name: type
                                                                .medicineType))
                                                    .toList() ??
                                                [],
                                            name: FieldKeys.kMedicineType,
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(
                                                  errorText: LocaleKeys
                                                      .kWarnningSelect
                                                      .tr())
                                            ]),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          CustomTextFieldArea(
                                            name: FieldKeys.kDescription,
                                            labelText:
                                                LocaleKeys.kDescription.tr(),
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
