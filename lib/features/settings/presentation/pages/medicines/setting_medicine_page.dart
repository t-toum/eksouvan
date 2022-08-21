import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class SettingMedicinePage extends StatelessWidget {
  const SettingMedicinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.kListMedicine.tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkWell(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListTile(
                        leading: const Image(
                          image: AssetImage(AppImages.medicine),
                          width: 35,
                          height: 35,
                        ),
                        title: Text(
                          LocaleKeys.kListAllMedicine.tr(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    AppNavigator.navigateTo(AppRoute.listMedicineRoute);
                  },
                ),
                InkWell(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListTile(
                        leading: const Image(
                          image: AssetImage(AppImages.medicine),
                          width: 35,
                          height: 35,
                        ),
                        title: Text(
                          LocaleKeys.kListAllMedicineType.tr(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    AppNavigator.navigateTo(AppRoute.listMedicineTypeRoute);
                  },
                ),
              ],
            )),
      ),
    );
  }
}
