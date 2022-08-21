import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_cubit.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_state.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../widgets/setting_item.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingCubit>();
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        if (state.dataStatus == DataStatus.loading) {
          return const LoadingWidget(
            showImage: false,
          );
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(LocaleKeys.kSetting.tr()),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SettingItem(
                            title: LocaleKeys.kLanguage.tr(),
                            icon: AppImages.translate_black,
                            trailing: SizedBox(
                              width: 80,
                              child: FlutterSwitch(
                                width: 80,
                                height: 40,
                                valueFontSize: 12,
                                toggleSize: 30.0,
                                value: cubit.lang,
                                padding: 8.0,
                                activeText: LocaleKeys.kEngLabel.tr(),
                                inactiveText: LocaleKeys.kLaoLabel.tr(),
                                activeColor: AppColors.primaryColor,
                                inactiveColor: AppColors.primaryColor,
                                showOnOff: true,
                                onToggle: (val) {
                                  cubit.onChangedLang(
                                      isCheck: val, context: context);
                                },
                              ),
                            ),
                          ),
                          const Divider(),
                          SettingItem(
                            title: LocaleKeys.kUser.tr(),
                            icon: AppImages.user,
                            onTap: () {
                              AppNavigator.navigateTo(
                                  AppRoute.settingUserRoute);
                            },
                          ),
                          const Divider(),
                          // SettingItem(
                          //   title: LocaleKeys.kPatinet.tr(),
                          //   icon: AppImages.patient,
                          // ),
                          // const Divider(),
                          SettingItem(
                              title: LocaleKeys.kMedicine.tr(),
                              icon: AppImages.medicine,
                              onTap: (() => AppNavigator.navigateTo(
                                  AppRoute.settingMedicineRoute))),
                          // const Divider(),
                          // SettingItem(
                          //   title: LocaleKeys.kDeases.tr(),
                          //   icon: AppImages.deases,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      AppNavigator.openDialog(
                        title: LocaleKeys.kWarning.tr(),
                        content: LocaleKeys.kLogoutDes.tr(),
                        onPressed: () {
                          cubit.getLogout();
                        },
                      );
                    },
                    child: Text(
                      LocaleKeys.kLogout.tr(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
