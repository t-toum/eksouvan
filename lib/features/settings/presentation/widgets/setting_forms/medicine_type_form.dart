import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/field_keys.dart';
import '../../../../../core/utils/form_builder_validator.dart';
import '../../../../../core/widgets/custom_textfield.dart';
import '../../../../../core/widgets/custom_textfield_area.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../cubit/setting_cubit.dart';
import '../../cubit/setting_state.dart';

class MedicineTypeForm extends StatelessWidget {
  const MedicineTypeForm({Key? key}) : super(key: key);

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
            labelText: LocaleKeys.kMedicineTypeName.tr(),
            name: 'medicineType',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: LocaleKeys.kRequiredField.tr())
            ]),
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
