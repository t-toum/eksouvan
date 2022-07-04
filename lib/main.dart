import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/locators/service_locator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'core/utils/app_navigator.dart';
import 'core/utils/custom_theme.dart';
import 'core/utils/router.dart';

void main() async {
  await configureDependencies();
  runApp(EasyLocalization(
    path: Languages.langPath,
    supportedLocales: const [
      Locale(Languages.loCode),
      Locale(Languages.enCode)
    ],
    fallbackLocale: const Locale(Languages.enCode),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Eksouvan',
      theme: buildTheme(),
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppRoute.generateRoute,
      initialRoute: AppRoute.homeRoute,
    );
  }
}
