import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_cubit.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_state.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../core/utils/app_navigator.dart';
import '../../../../../core/widgets/item_list.dart';
import '../../widgets/modal_widget.dart';
import '../../widgets/setting_forms/medicine_form.dart';

class ListMedicinePage extends StatelessWidget {
  const ListMedicinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingCubit>();
    return BlocBuilder<SettingCubit, SettingState>(builder: ((context, state) {
      if (state.dataStatus == DataStatus.loading) {
        return const LoadingWidget(
          showImage: false,
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.kListAllMedicine.tr()),
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
                      child: const MedicineFrom(),
                    ),
                    onSave: () {
                      cubit.onSaveMedicine();
                    },
                  ),
                ));
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(state.listMedicine?.length ?? 0, (index) {
              return ItemList(
                title: state.listMedicine?[index].medicine,
                description: state.listMedicine?[index].description,
                type: cubit.getMedicineTypeName(
                    id: state.listMedicine?[index].type),
              );
            }),
          ),
        ),
      );
    }));
  }
}
