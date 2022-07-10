import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/enum.dart';
import 'package:eksouvan/core/widgets/widget_builder.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/router.dart';
import '../widgets/menu_items.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetBuilders.customAppbar(),
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
                      AppNavigator.navigateTo(AppRoute.registerPatientRoute);
                      break;
                    case MenuItemType.history:
                      AppNavigator.navigateTo(AppRoute.historyRoute);
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
