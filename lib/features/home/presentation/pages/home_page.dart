import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/enum.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
import 'package:eksouvan/core/widgets/widget_builder.dart';
import 'package:eksouvan/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/router.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../widgets/menu_items.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.dataStatus == DataStatus.loading) {
          return const Scaffold(
            body: LoadingWidget(),
          );
        }
        return AppTemplate(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  AppNavigator.navigateTo(AppRoute.settingRoute);
                },
                icon: const Icon(
                  Icons.settings,
                  size: 40,
                ),
              ),
            ),
          ],
          title: '',
          body: Container(
            padding: const EdgeInsets.all(30),
            child: GridView.count(
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              children: List.generate(
                menuList.length,
                (index) {
                  return MenuItems(
                    labelKey: menuList[index].labelKey,
                    onTap: () {
                      switch (menuList[index].menuItemType) {
                        case MenuItemType.register:
                          AppNavigator.navigateTo(
                              AppRoute.registerPatientRoute);
                          break;
                        case MenuItemType.history:
                          AppNavigator.navigateTo(AppRoute.historyRoute);
                          break;
                        case MenuItemType.dailyDiagnose:
                          AppNavigator.navigateTo(AppRoute.dailyDiagnoseRoute);
                          break;
                        case MenuItemType.dailyPatient:
                          AppNavigator.navigateTo(AppRoute.dialyPatient);
                          break;
                        case MenuItemType.appointment:
                          AppNavigator.navigateTo(AppRoute.appointmentRout);
                          break;
                        case MenuItemType.report:
                          AppNavigator.navigateTo(AppRoute.reportRoute);
                          break;
                        default:
                          AppNavigator.navigateTo("not_found");
                      }
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

List<MenuItemData> menuList = [
  MenuItemData(
      labelKey: "kNewRegisterLabel", menuItemType: MenuItemType.register),
  MenuItemData(labelKey: "kHistoryLabel", menuItemType: MenuItemType.history),
  MenuItemData(
      labelKey: "kDailyDiagnoseLabel",
      menuItemType: MenuItemType.dailyDiagnose),
  MenuItemData(
      labelKey: "kAppointment", menuItemType: MenuItemType.appointment),
  MenuItemData(
      labelKey: "kDailyPatient", menuItemType: MenuItemType.dailyPatient),
  MenuItemData(labelKey: "kReport", menuItemType: MenuItemType.report),
];

class MenuItemData {
  final String labelKey;
  final MenuItemType menuItemType;
  MenuItemData({required this.labelKey, required this.menuItemType});
}
