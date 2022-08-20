import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/core/utils/form_builder_validator.dart';
import 'package:eksouvan/core/widgets/costom_dropdown.dart';
import 'package:eksouvan/core/widgets/custom_textfield.dart';
import 'package:eksouvan/core/widgets/custom_textfield_area.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_cubit.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_state.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/widgets/item_list.dart';
import '../widgets/modal_widget.dart';
import '../widgets/setting_forms/medicine_form.dart';

class SettingMedicinePage extends StatelessWidget {
  const SettingMedicinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingCubit>();
    return BlocBuilder<SettingCubit, SettingState>(
      builder: ((context, state) {
        if (state.dataStatus == DataStatus.loading) {
          return const LoadingWidget(showImage: false);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.kListMedicine.tr()),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    AppNavigator.openModel(
                        chiled: BlocProvider<SettingCubit>.value(
                      value: cubit..getMedicineType(),
                      child: ModalWidget(
                        title: LocaleKeys.kAddMedicine.tr(),
                        body: FormBuilder(
                          key: cubit.medicineKey,
                          child: MedicineFrom(),
                        ),
                        onSave: () {
                          cubit.onSaveMedicine();
                        },
                      ),
                    ));
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(
                  state.listMedicine?.length ?? 0,
                  (index) => ItemList(
                    title: state.listMedicine?[index].medicine,
                    description: state.listMedicine?[index].description,
                    type: state.listMedicine?[index].type,
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                    onTap: () {
                      AppNavigator.openModel(
                          chiled: BlocProvider<SettingCubit>.value(
                        value: cubit,
                        child: ModalWidget(
                          isUpdate: true,
                          title: LocaleKeys.kEditMedicine.tr(),
                          body: MedicineFrom(),
                          onSave: () {
                            print("On save");
                          },
                        ),
                      ));
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
