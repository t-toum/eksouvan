import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_cubit.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/dropdown_item.dart';
import '../../../../../core/utils/field_keys.dart';
import '../../../../../core/utils/form_builder_validator.dart';
import '../../../../../core/widgets/costom_dropdown.dart';
import '../../../../../core/widgets/custom_textfield.dart';
import '../../../../../core/widgets/custom_textfield_area.dart';
import '../../../../../generated/locale_keys.g.dart';

class MedicineFrom extends StatelessWidget {
  const MedicineFrom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingCubit>();
    return BlocBuilder<SettingCubit, SettingState>(builder: ((context, state) {
      if (state.dataStatus == DataStatus.loading) {
        return const CircularProgressIndicator(
          color: AppColors.primaryColor,
        );
      }
      return Column(
        children: [
          CustomTextField(
            isRequired: true,
            labelText: LocaleKeys.kMedicineName.tr(),
            name: 'medicine',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: LocaleKeys.kRequiredField.tr())
            ]),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomDropdown(
            isRequired: true,
            initialValue: cubit.pickedMedicine,
            labelText: LocaleKeys.kMedicineType.tr(),
            hintText: LocaleKeys.kSelectMedicineType.tr(),
            items: state.listMedicineType
                    ?.map((type) =>
                        DropdwonItems(id: type.id, name: type.medicineType))
                    .toList() ??
                [],
            name: FieldKeys.kMedicineType,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: LocaleKeys.kWarnningSelect.tr())
            ]),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFieldArea(
            labelText: LocaleKeys.kDescription.tr(),
            name: FieldKeys.kDescription,
          )
        ],
      );
    }));
  }
}
