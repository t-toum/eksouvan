import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../core/utils/app_navigator.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/item_list.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../cubit/setting_cubit.dart';
import '../../cubit/setting_state.dart';
import '../../widgets/modal_widget.dart';
import '../../widgets/setting_forms/medicine_type_form.dart';

class ListMedicineTypePage extends StatelessWidget {
  const ListMedicineTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingCubit>();
    return BlocBuilder<SettingCubit, SettingState>(builder: ((context, state) {
      if (state.dataStatus == DataStatus.loading) {
        return const Center(
          child: LoadingWidget(
            showImage: false,
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.kListAllMedicineType.tr()),
          actions: [
            IconButton(
              onPressed: () {
                AppNavigator.openModel(
                    chiled: BlocProvider<SettingCubit>.value(
                  value: cubit..getMedicineType(),
                  child: ModalWidget(
                    title: LocaleKeys.kAddMedicineType.tr(),
                    body: FormBuilder(
                      key: cubit.medicineTypeKey,
                      child: const MedicineTypeForm(),
                    ),
                    onSave: () {
                      cubit.onSaveMedicineType();
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
            children:
                List.generate(state.listMedicineType?.length ?? 0, (index) {
              return ItemList(
                title: state.listMedicineType?[index].medicineType,
                description: state.listMedicineType?[index].description,
                type: '',
                trailing: IconButton(
                  onPressed: () {
                    AppNavigator.openDialog(
                      title: LocaleKeys.kWarning.tr(),
                      content: LocaleKeys.kDeleteMessage.tr(),
                      onPressed: () {
                        AppNavigator.goBack();
                        cubit.deleteMedicineType(
                            id: state.listMedicineType?[index].id ?? '');
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              );
            }),
          ),
        ),
      );
    }));
  }
}
