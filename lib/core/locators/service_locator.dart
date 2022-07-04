import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/locators/service_locator.config.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../firebase_options.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppNavigator();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  $initGetIt(getIt);
}
